return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        -- Formatadores
        null_ls.builtins.formatting.prettier,

        -- Linters (mostra erros e avisos)
        null_ls.builtins.diagnostics.eslint,

        -- Ações de código (permite correções automáticas)
        null_ls.builtins.code_actions.eslint,
      },
    })

    -- Configuração do "Format on Save" (Formatar ao Salvar)
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
      desc = 'Format file with LSP on save',
    })
  end,
}
