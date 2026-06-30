-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.signcolumn = "number"
vim.opt.numberwidth = 1

vim.diagnostic.config({
  signs = false,
  virtual_text = {
    prefix = "",
    spacing = 2,
  },
})
