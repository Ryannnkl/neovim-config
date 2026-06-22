-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.signcolumn = "no"
vim.opt.numberwidth = 2

vim.diagnostic.config({
  signs = false,
  virtual_text = {
    prefix = "",
    spacing = 2,
  },
})
