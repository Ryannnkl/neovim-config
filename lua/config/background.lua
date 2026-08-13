local M = {}

M.transparent = true

local groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "FloatTitle",
  "SignColumn",
  "FoldColumn",
  "LineNr",
  "CursorLineNr",
  "EndOfBuffer",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
  "WinSeparator",
}

function M.clear()
  for _, group in ipairs(groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if ok then
      hl.bg = nil
      hl.ctermbg = nil
      pcall(vim.api.nvim_set_hl, 0, group, hl)
    end
  end
end

function M.apply()
  if M.transparent then
    M.clear()
  end
end

function M.restore()
  M.transparent = false
  vim.cmd.colorscheme(require("config.colorscheme").get("tokyonight"))
end

function M.enable()
  M.transparent = true
  M.apply()
end

function M.toggle()
  if M.transparent then
    M.restore()
    vim.notify("Background restaurado", vim.log.levels.INFO)
  else
    M.enable()
    vim.notify("Background transparente", vim.log.levels.INFO)
  end
end

return M
