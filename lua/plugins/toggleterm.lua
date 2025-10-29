return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      on_open = function(term)
        vim.cmd("startinsert!")

        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
          noremap = true,
          silent = true,
          desc = "Exit terminal mode",
          buffer = term.bufnr,
        })

        vim.keymap.set("t", "<C-c>", [[<C-c>]], {
          noremap = true,
          silent = true,
          desc = "Send interrupt signal",
          buffer = term.bufnr,
        })
      end,
    })
  end,
}
