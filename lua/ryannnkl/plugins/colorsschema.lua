return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },
  {
    "erl-koenig/theme-hub.nvim", -- https://github.com/erl-koenig/theme-hub seletor de temas :ThemeHub
    dependencies = {
      "nvim-lua/plenary.nvim",
      "rktjmp/lush.nvim",
    },
    config = function()
      require("theme-hub").setup({
        install_dir = vim.fn.stdpath("data") .. "/theme-hub",
        auto_install_on_select = true,
        apply_after_install = true,
        persistent = false,
      })
    end,
  },
}
