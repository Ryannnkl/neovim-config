return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- Desabilitar o netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Configurar o nvim-tree
    require('nvim-tree').setup({
      sort_by = 'name',
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })

    -- Criar o atalho para o COMANDO :NvimTreeToggle
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {
      desc = 'Toggle file explorer',
      silent = true,
    })
  end,
}
