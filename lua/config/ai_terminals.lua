local M = {}

local agents = {
  claude = { id = 101, cmd = "claude", display_name = "Claude Code" },
  codex = { id = 102, cmd = "codex", display_name = "Codex" },
  gemini = { id = 103, cmd = "gemini", display_name = "Gemini" },
}

local last_agent = "claude"
local terminals = {}

local function shell_quote(value)
  return vim.fn.shellescape(value)
end

local function get_terminal(agent)
  local config = agents[agent]
  if not config then
    return nil
  end

  if terminals[agent] then
    return terminals[agent]
  end

  local Terminal = require("toggleterm.terminal").Terminal
  terminals[agent] = Terminal:new({
    id = config.id,
    cmd = config.cmd,
    display_name = config.display_name,
    direction = "vertical",
    size = function()
      return math.min(80, math.max(50, math.floor(vim.o.columns * 0.38)))
    end,
    close_on_exit = false,
    hidden = true,
  })

  return terminals[agent]
end

function M.toggle(agent)
  last_agent = agent or last_agent
  local term = get_terminal(last_agent)
  if term then
    term:toggle()
  end
end

function M.send(agent, text)
  local term = get_terminal(agent or last_agent)
  if not term then
    return
  end

  if not term:is_open() then
    term:open()
  end

  term:send(text, true)
end

function M.send_current_file(agent)
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Buffer atual nao tem arquivo no disco", vim.log.levels.WARN)
    return
  end

  M.send(agent, shell_quote(path))
end

function M.send_selection(agent)
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local end_line = end_pos[2]

  if start_line == 0 or end_line == 0 then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  M.send(agent, table.concat(lines, "\n"))
end

return M
