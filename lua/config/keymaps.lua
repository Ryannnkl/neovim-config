-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>uC", require("config.colorscheme").pick, { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>ub", require("config.background").toggle, { desc = "Toggle background" })
