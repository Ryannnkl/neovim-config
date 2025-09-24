return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- Ícones para arquivos
  { 'nvim-tree/nvim-web-devicons', lazy = true },

   require('plugins.telescope'),
   require('plugins.nvim-tree'),
   require('plugins.formatter'),
   require('plugins.lsp'),
   require('plugins.ui'),
   require('plugins/dap'),
}
