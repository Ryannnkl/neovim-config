return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { [[<C-\>]], "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
      { [[<C-\>]], [[<C-\><C-n><cmd>ToggleTerm<cr>]], mode = "t", desc = "Toggle Terminal" },
      { "<leader>ac", function() require("config.ai_terminals").toggle("claude") end, desc = "Claude Code" },
      { "<leader>ax", function() require("config.ai_terminals").toggle("codex") end, desc = "Codex" },
      { "<leader>ag", function() require("config.ai_terminals").toggle("gemini") end, desc = "Gemini" },
      { "<leader>af", function() require("config.ai_terminals").send_current_file() end, desc = "AI Send File" },
      { "<leader>as", function() require("config.ai_terminals").send_selection() end, mode = "x", desc = "AI Send Selection" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Float" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal Horizontal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal Vertical" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      float_opts = {
        border = "curved",
        width = function()
          return math.floor(vim.o.columns * 0.85)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
      },
    },
  },
}
