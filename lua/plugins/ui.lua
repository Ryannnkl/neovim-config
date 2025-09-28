return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Comando para instalar/atualizar parsers
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        -- Lista de parsers de linguagem a serem instalados
        ensure_installed = { 'javascript', 'typescript', 'tsx', 'lua', 'json', 'html', 'css' },

        -- Ativar o syntax highlighting
        highlight = {
          enable = true,
        },

        -- Ativar o módulo de indentação
        indent = {
          enable = true,
        },
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Dependência para ícones
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'gruvbox-material', -- Usa o mesmo tema do seu editor
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Carrega o plugin quando necessário
    config = function()
      require('which-key').setup({
        -- sua configuração personalizada aqui, se desejar
        -- a configuração padrão já é excelente
      })
    end,
  },
  {
    'sainnhe/gruvbox-material',
    lazy = true,
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = true
      vim.cmd.colorscheme('gruvbox-material')
    end
  },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  }
}
