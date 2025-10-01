return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    lualine.setup({
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "os.date('%A %H:%M')", "data", "require'lsp-status'.status()", "filename" },
        lualine_x = { "fileformat", "filetype" },
        lualine_y = { "searchcount" },
        lualine_z = { "location" },
      },
    })
  end,
}
