return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local api = require('nvim-tree.api')

    local function my_on_attach(bufnr)
      local function opts(desc)
        return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      
      api.config.mappings.default_on_attach(bufnr)

      local function open_file(cmd)
        local node = api.tree.get_node_under_cursor()
        if node and node.type == 'file' then
          api.tree.close()
          vim.cmd(cmd .. ' ' .. vim.fn.fnameescape(node.absolute_path))
        end
      end

      vim.keymap.set('n', 's', function() open_file('vsplit') end, opts('Open in V-Split'))
      vim.keymap.set('n', 'i', function() open_file('split') end, opts('H-Split'))
      vim.keymap.set('n', 't', function() open_file('tabnew') end, opts('Open in New Tab'))
    end

    require('nvim-tree').setup({
      on_attach = my_on_attach,
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

    vim.keymap.set('n', '<leader>e', api.tree.toggle, { desc = 'Toggle file explorer' })
  end,
}
