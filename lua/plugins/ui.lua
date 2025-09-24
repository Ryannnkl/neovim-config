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
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navegação
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = 'Go to next git hunk' })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = 'Go to previous git hunk' })

          -- Ações
          map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage git hunk' })
          map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset git hunk' })
          map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = 'Stage git hunk' })
          map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = 'Reset git hunk' })
          map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage git buffer' })
          map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
          map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset git buffer' })
          map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview git hunk' })
          map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = 'Git blame line' })
          map('n', '<leader>hd', gs.diffthis, { desc = 'Git diff against index' })
          map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Git diff against last commit' })
        end,
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
}
