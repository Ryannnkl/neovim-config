return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {},
  },
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "material"
    end,
  },
  {
    "vague-theme/vague.nvim",
    priority = 1000,
    opts = {},
  },
  { "rebelot/kanagawa.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
}
