return {
  -- Instalação dos Debug Adapters via Mason
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
    config = function()
      require('mason-nvim-dap').setup({
        -- Instala automaticamente os debug adapters listados aqui
        ensure_installed = { 'node2' },
      })
    end,
  },

  -- O motor do Debugger (DAP)
  {
    'mfussenegger/nvim-dap',
    dependencies = { 'rcarriga/nvim-dap-ui' },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      -- Abre e fecha a UI do DAP automaticamente
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Adiciona a configuração para debugar JavaScript/TypeScript com Node.js
      dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = { os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
      }

      -- ############### INÍCIO DA MUDANÇA ###############
      -- Agora esta lista contém DUAS configurações possíveis
      dap.configurations.javascript = {
        -- CONFIGURAÇÃO 1: "LAUNCH" (JÁ EXISTIA)
        {
          type = 'node2',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = vim.fn.getcwd(),
        },
        -- CONFIGURAÇÃO 2: "ATTACH" (A QUE ADICIONAMOS)
        {
          type = 'node2',
          request = 'attach',
          name = 'Attach to process',
          processId = require('dap.utils').pick_process,
          cwd = vim.fn.getcwd(),
        },
      }
      -- ############### FIM DA MUDANÇA ###############

      dap.configurations.typescript = dap.configurations.javascript
      dap.configurations.javascriptreact = dap.configurations.javascript
      dap.configurations.typescriptreact = dap.configurations.javascript
    end,
  },

  -- A Interface Visual para o DAP
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dapui = require('dapui')
      dapui.setup()

      -- Atalhos do teclado para o modo de debug
      local dap = require('dap')
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F6>', dap.terminate, { desc = 'Debug: Terminate' })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<leader>du', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = 'Debug: Toggle REPL' })
      vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run Last' })
    end,
  },
}
