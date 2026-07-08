local M = {}

local uv = vim.uv or vim.loop

local defaults = {
  enabled = true,
  debounce_ms = 250,
  burst_threshold = 4,
  burst_window_ms = 3000,
  burst_suppress_ms = 30000,
  max_watchers = 2000,
  max_file_size = 1024 * 1024 * 5,
  notify = true,
  root_markers = { ".git" },
  ignored_dirs = {
    ".git",
    ".hg",
    ".svn",
    ".cache",
    ".next",
    ".nuxt",
    ".svelte-kit",
    ".turbo",
    ".venv",
    "coverage",
    "build",
    "dist",
    "node_modules",
    "out",
    "target",
    "tmp",
    "vendor",
  },
  ignored_files = {
    "%.eslintcache$",
    "%.d%.ts$",
    "%.log$",
    "%.map$",
    "%.swp$",
    "%.swo$",
    "^tsconfig%.tsbuildinfo$",
    "^tsconfig%..*%.tsbuildinfo$",
    "%.tsbuildinfo$",
    "%.tmp$",
    "%.temp$",
    "~$",
  },
  low_priority_files = {
    "^tsconfig%.json$",
    "^tsconfig%..*%.json$",
  },
}

local state = {
  config = vim.deepcopy(defaults),
  root = nil,
  watchers = {},
  watcher_count = 0,
  pending = {},
  debounce_timer = nil,
  event_history = {},
  suppress_until = {},
  started = false,
  did_max_watchers_notify = false,
}

local function notify(message, level)
  if state.config.notify then
    vim.notify(message, level or vim.log.levels.INFO)
  end
end

local function joinpath(parent, child)
  if parent:sub(-1) == "/" then
    return parent .. child
  end

  return parent .. "/" .. child
end

local function normalize(path)
  if not path or path == "" then
    return nil
  end

  return vim.fs.normalize(vim.fn.fnamemodify(path, ":p"))
end

local function basename(path)
  return vim.fs.basename(path)
end

local function as_set(values)
  local set = {}
  for _, value in ipairs(values or {}) do
    set[value] = true
  end
  return set
end

local function ms_to_ns(ms)
  return ms * 1000000
end

local function relative_to_root(path)
  if not state.root then
    return path
  end

  if path == state.root then
    return ""
  end

  local prefix = state.root .. "/"
  if vim.startswith(path, prefix) then
    return path:sub(#prefix + 1)
  end

  return path
end

local function is_ignored_file(path)
  local name = basename(path)

  for _, pattern in ipairs(state.config.ignored_files) do
    if name:match(pattern) then
      return true
    end
  end

  return false
end

local function is_low_priority_file(path)
  local name = basename(path)

  for _, pattern in ipairs(state.config.low_priority_files) do
    if name:match(pattern) then
      return true
    end
  end

  return false
end

local function path_has_ignored_dir(path)
  local ignored = as_set(state.config.ignored_dirs)
  local relative = relative_to_root(path)

  for part in relative:gmatch("[^/]+") do
    if ignored[part] then
      return true
    end
  end

  return false
end

local function stat(path)
  local ok, result = pcall(uv.fs_stat, path)
  if not ok then
    return nil
  end

  return result
end

local function should_focus(path)
  path = normalize(path)

  if not path or not state.root or path_has_ignored_dir(path) or is_ignored_file(path) then
    return false
  end

  if path ~= state.root and not vim.startswith(path, state.root .. "/") then
    return false
  end

  local until_time = state.suppress_until[path]
  if until_time and until_time > uv.hrtime() then
    return false
  end

  local file_stat = stat(path)
  if not file_stat or file_stat.type ~= "file" then
    return false
  end

  if file_stat.size and file_stat.size > state.config.max_file_size then
    return false
  end

  return true
end

local function record_file_event(path)
  local now = uv.hrtime()
  local window_start = now - ms_to_ns(state.config.burst_window_ms)
  local history = state.event_history[path] or {}
  local recent = {}

  for _, changed_at in ipairs(history) do
    if changed_at >= window_start then
      recent[#recent + 1] = changed_at
    end
  end

  recent[#recent + 1] = now
  state.event_history[path] = recent

  if #recent > state.config.burst_threshold then
    state.suppress_until[path] = now + ms_to_ns(state.config.burst_suppress_ms)
    state.pending[path] = nil
    return false
  end

  return true
end

local function find_target_window()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)

  if vim.bo[current_buf].buftype == "" then
    return current_win
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "" then
      return win
    end
  end

  return current_win
end

local function focus_file(path)
  if not should_focus(path) then
    return
  end

  local win = find_target_window()
  if vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_set_current_win(win)
  end

  local ok, err = pcall(vim.cmd, "keepalt edit " .. vim.fn.fnameescape(path))
  if not ok then
    notify("Nao consegui abrir arquivo alterado: " .. tostring(err), vim.log.levels.WARN)
    return
  end

  vim.cmd("silent! checktime")
  notify("Arquivo alterado por processo externo: " .. vim.fn.fnamemodify(path, ":~:."))
end

local function flush_pending()
  local newest_path
  local newest_time = 0
  local newest_low_priority_path
  local newest_low_priority_time = 0

  for path, changed_at in pairs(state.pending) do
    state.pending[path] = nil

    if should_focus(path) then
      vim.fn.bufadd(path)

      if is_low_priority_file(path) then
        if changed_at > newest_low_priority_time then
          newest_low_priority_path = path
          newest_low_priority_time = changed_at
        end
      elseif changed_at > newest_time then
        newest_path = path
        newest_time = changed_at
      end
    end
  end

  if newest_path or newest_low_priority_path then
    focus_file(newest_path or newest_low_priority_path)
  end
end

local function queue_file(path)
  path = normalize(path)
  if not path then
    return
  end

  if not should_focus(path) or not record_file_event(path) then
    return
  end

  state.pending[path] = uv.hrtime()

  state.debounce_timer = state.debounce_timer or uv.new_timer()
  state.debounce_timer:stop()
  state.debounce_timer:start(state.config.debounce_ms, 0, vim.schedule_wrap(flush_pending))
end

local scan_dir

local function watch_dir(dir)
  dir = normalize(dir)
  if not dir or state.watchers[dir] or path_has_ignored_dir(dir) then
    return
  end

  if state.watcher_count >= state.config.max_watchers then
    if not state.did_max_watchers_notify then
      notify("AiFileFocus atingiu o limite de watchers em " .. state.root, vim.log.levels.WARN)
      state.did_max_watchers_notify = true
    end
    return
  end

  local handle = uv.new_fs_event()
  local ok, err = handle:start(dir, {}, function(event_err, filename)
    if event_err or not filename then
      return
    end

    local path = joinpath(dir, filename)
    local file_stat = stat(path)

    if file_stat and file_stat.type == "directory" then
      scan_dir(path)
      return
    end

    queue_file(path)
  end)

  if not ok then
    handle:close()
    notify("Nao consegui observar " .. dir .. ": " .. tostring(err), vim.log.levels.WARN)
    return
  end

  state.watchers[dir] = handle
  state.watcher_count = state.watcher_count + 1
end

scan_dir = function(dir)
  dir = normalize(dir)
  if not dir or path_has_ignored_dir(dir) then
    return
  end

  watch_dir(dir)

  local ok, fs = pcall(uv.fs_scandir, dir)
  if not ok or not fs then
    return
  end

  while true do
    local name, type = uv.fs_scandir_next(fs)
    if not name then
      break
    end

    if type == "directory" and not as_set(state.config.ignored_dirs)[name] then
      scan_dir(joinpath(dir, name))
    end
  end
end

local function find_root()
  local bufname = vim.api.nvim_buf_get_name(0)
  local start = bufname ~= "" and vim.fs.dirname(bufname) or uv.cwd()
  local marker = vim.fs.find(state.config.root_markers, { path = start, upward = true })[1]

  if marker then
    return normalize(vim.fs.dirname(marker))
  end

  return normalize(uv.cwd())
end

function M.stop()
  for dir, handle in pairs(state.watchers) do
    if handle and not handle:is_closing() then
      handle:stop()
      handle:close()
    end
    state.watchers[dir] = nil
  end

  if state.debounce_timer and not state.debounce_timer:is_closing() then
    state.debounce_timer:stop()
  end

  state.root = nil
  state.watcher_count = 0
  state.pending = {}
  state.event_history = {}
  state.suppress_until = {}
  state.started = false
  state.did_max_watchers_notify = false
end

function M.start(root)
  M.stop()

  state.root = normalize(root) or find_root()
  if not state.root then
    return
  end

  scan_dir(state.root)
  state.started = true
  notify("AiFileFocus observando " .. vim.fn.fnamemodify(state.root, ":~"))
end

function M.restart()
  M.start(find_root())
end

function M.toggle()
  if state.started then
    M.stop()
    notify("AiFileFocus pausado")
  else
    M.start(find_root())
  end
end

function M.status()
  if not state.started then
    notify("AiFileFocus pausado")
    return
  end

  notify(("AiFileFocus observando %s (%d diretorios)"):format(state.root, state.watcher_count))
end

function M.setup(opts)
  state.config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})

  vim.api.nvim_create_user_command("AiFileFocusStart", function(command)
    M.start(command.args ~= "" and command.args or nil)
  end, { nargs = "?", complete = "dir", force = true })

  vim.api.nvim_create_user_command("AiFileFocusStop", M.stop, { force = true })
  vim.api.nvim_create_user_command("AiFileFocusToggle", M.toggle, { force = true })
  vim.api.nvim_create_user_command("AiFileFocusStatus", M.status, { force = true })

  local group = vim.api.nvim_create_augroup("user_ai_file_focus", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    callback = function(event)
      local path = normalize(event.file)
      if path then
        state.suppress_until[path] = uv.hrtime() + 1500000000
      end
    end,
  })

  vim.api.nvim_create_autocmd("DirChanged", {
    group = group,
    callback = function()
      if state.started then
        M.restart()
      end
    end,
  })

  if state.config.enabled and #vim.api.nvim_list_uis() > 0 then
    M.start(find_root())
  end
end

return M
