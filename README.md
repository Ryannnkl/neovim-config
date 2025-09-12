# Configuração Neovim

Esta é uma configuração pessoal para o Neovim, construída em Lua e gerenciada com [lazy.nvim](https://github.com/folke/lazy.nvim). O objetivo é ter um ambiente de desenvolvimento leve, rápido e funcional, com foco em desenvolvimento web.

## ✨ Features

- **Gerenciador de Plugins**: Plugins são carregados de forma preguiçosa (lazy-loaded) com `lazy.nvim`.
- **Aparência**: Tema `tokyonight` com ícones `nvim-web-devicons` e uma statusline customizada com `lualine`.
- **Explorador de Arquivos**: `nvim-tree` para uma navegação de arquivos eficiente.
- **Busca Inteligente**: Busca fuzzy de arquivos, texto e buffers com `telescope.nvim`.
- **LSP & Autocomplete**: Integração completa com o Language Server Protocol (`nvim-lspconfig`) para diagnósticos, `mason.nvim` para gerenciar LSPs, e `nvim-cmp` para autocompletar código.
- **Formatação e Linting**: Formatação de código ao salvar e linting com `none-ls.nvim` (usando Prettier e ESLint).
- **Integração Git**: Sinais de Git na gutter e comandos úteis com `gitsigns.nvim`.
- **Syntax Highlighting**: Destaque de sintaxe aprimorado com `nvim-treesitter`.

## ⚡ Pré-requisitos

- **Neovim**: Versão `0.11.4` ou superior.
- **Git**: Necessário para clonar a configuração e para os plugins.
- **Nerd Font**: Necessária para que os ícones sejam exibidos corretamente. Recomendo a [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads).
- **Ferramentas de Build**: Compilador C (como `gcc`) para o `nvim-treesitter`.
- **Node.js**: Necessário para os LSPs de JavaScript/TypeScript e para o `prettier`/`eslint`.

## 🔌 Plugins Principais

| Plugin | Descrição |
| --- | --- |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Gerenciador de Plugins |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Tema de cores |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline customizável |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | Explorador de arquivos |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Busca fuzzy (fuzzy finder) |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configuração para servidores de linguagem (LSP) |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Gerenciador de LSPs, formatadores e linters |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Motor de autocompletar |
| [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) | Fonte para formatação e linting |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Melhora o syntax highlighting e indentação |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Integração com Git |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Mostra os atalhos disponíveis |

## ⌨️ Atalhos Principais

A tecla `Líder` está mapeada para a barra de **espaço**.

| Atalho | Ação |
| --- | --- |
| `<leader>e` | Abrir/Fechar o explorador de arquivos (`NvimTree`) |
| `<leader>ff` | Encontrar arquivos (`Telescope`) |
| `<leader>fg` | Buscar texto no projeto (`Telescope live_grep`) |
| `<leader>fb` | Listar buffers abertos (`Telescope`) |
| `gd` | Ir para a definição da função/variável |
| `K` | Mostrar documentação (hover) |
| `<leader>ca` | Ver ações de código disponíveis (Code Action) |
| `<leader>rn` | Renomear símbolo |
| `<leader>hs` | Adicionar "hunk" atual ao stage do Git (`gitsigns`) |
| `<leader>hr` | Resetar "hunk" atual (`gitsigns`) |
