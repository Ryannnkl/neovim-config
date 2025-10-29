-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

keymap.set("n", "<C-z>", "u", { noremap = true, silent = true })

-- DAP keymaps
keymap.set("n", "<leader>db", function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint" })
keymap.set("n", "<leader>dc", function() require('dap').continue() end, { desc = "Continue" })
keymap.set("n", "<leader>do", function() require('dap').step_over() end, { desc = "Step over" })
keymap.set("n", "<leader>di", function() require('dap').step_into() end, { desc = "Step into" })
keymap.set("n", "<leader>du", function() require('dap').step_out() end, { desc = "Step out" })
keymap.set("n", "<leader>dt", function() require('dap').terminate() end, { desc = "Terminate" })
keymap.set("n", "<leader>dd", function() require('dapui').toggle() end, { desc = "Toggle DAP UI" })
