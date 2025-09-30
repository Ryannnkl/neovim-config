# Neovim Configuration

Essa é uma configuração Neovim moderna, construída em Lua e gerenciada com o plugin manager [lazy.nvim](https://github.com/folke/lazy.nvim).

## ✨ Funcionalidades

- **Gerenciador de Plugins**: Plugins são carregados de forma preguiçosa (lazy-loaded) com `lazy.nvim`.
- **Interface Moderna**: Um dashboard de boas-vindas com `alpha-nvim`, uma statusline customizada com `lualine.nvim` e o tema `tokyonight.nvim`.
- **Explorador de Arquivos**: `nvim-tree` para uma navegação de arquivos eficiente.
- **Busca Inteligente**: Busca fuzzy de arquivos, texto e mais com `telescope.nvim`.
- **LSP & Autocomplete**:
  - Integração completa com o Language Server Protocol (`nvim-lspconfig`).
  - Gerenciamento fácil de LSPs, formatadores e linters com `mason.nvim`.
  - Autocomplete inteligente com `nvim-cmp`, incluindo suporte a snippets.
- **Assistente de IA**: Integração com o Google Gemini (`gemini.nvim`) para autocompletar código e chat.
- **Formatação e Linting**:
  - Formatação de código ao salvar com `conform.nvim` (suporte a Prettier, Stylua, Black, etc.).
  - Linting com `nvim-lint`.
- **Integração Git**: Sinais de Git na gutter (`gitsigns.nvim`) e uma interface completa para o Git com `lazygit.nvim`.
- **Syntax Highlighting**: Destaque de sintaxe aprimorado com `nvim-treesitter`.
- **Qualidade de Vida**: Auto-fechamento de tags (`nvim-ts-autotag`), auto-pares de brackets (`nvim-autopairs`), e um visualizador de atalhos (`which-key.nvim`).
- **Diagnósticos**: Uma lista de diagnósticos bonita e funcional com `trouble.nvim`.

## ⚡ Pré-requisitos

- **Neovim**: Versão `0.9.0` ou superior.
- **Git**: Necessário para clonar a configuração e para os plugins.
- **Nerd Font**: Necessária para que os ícones sejam exibidos corretamente (ex: [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads)).
- **Compilador C**: Necessário para o `nvim-treesitter`.
- **Node.js**: Necessário para LSPs de JavaScript/TypeScript e ferramentas como Prettier e ESLint.
- **Python**: Necessário para linters/formatadores de Python como `pylint`, `isort` e `black`.
- **Lazygit**: Necessário para a integração com o `lazygit.nvim`.
- **Chave de API do Gemini**: Para usar as funcionalidades de IA, a variável de ambiente `GEMINI_API_KEY` deve ser configurada.

## 🔌 Plugins Principais

| Plugin                                                                | Descrição                                       |
| --------------------------------------------------------------------- | ----------------------------------------------- |
| [lazy.nvim](https://github.com/folke/lazy.nvim)                       | Gerenciador de Plugins                          |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)           | Tema de cores                                   |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)          | Statusline customizável                         |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)           | Explorador de arquivos                          |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)    | Busca fuzzy (fuzzy finder)                      |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)            | Configuração para servidores de linguagem (LSP) |
| [mason.nvim](https://github.com/williamboman/mason.nvim)              | Gerenciador de LSPs, formatadores e linters     |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                       | Motor de autocompletar                          |
| [conform.nvim](https://github.com/stevearc/conform.nvim)              | Formatação de código                            |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint)                | Ferramenta de linting                           |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Melhora o syntax highlighting e indentação      |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)           | Integração com Git (sinais na gutter)           |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)              | Interface para o `lazygit`                      |
| [gemini.nvim](https://github.com/kiddos/gemini.nvim)                  | Integração com a IA do Google Gemini            |
| [trouble.nvim](https://github.com/folke/trouble.nvim)                 | Visualizador de diagnósticos                    |
| [which-key.nvim](https://github.com/folke/which-key.nvim)             | Mostra os atalhos disponíveis                   |

## ⌨️ Atalhos Principais

A tecla `Líder` está mapeada para a barra de **espaço**.

### Gerais e Janelas

| Atalho                      | Ação                                           |
| --------------------------- | ---------------------------------------------- |
| `jk`                        | Sair do modo de inserção (em modo de inserção) |
| `<leader>sv`                | Dividir a janela verticalmente                 |
| `<leader>sh`                | Dividir a janela horizontalmente               |
| `<leader>sx`                | Fechar a divisão (split) atual                 |
| `<leader>sm`                | Maximizar/minimizar a divisão atual            |
| `<leader>to`                | Abrir nova aba                                 |
| `<leader>tx`                | Fechar aba atual                               |
| `<leader>tn` / `<leader>tp` | Ir para a próxima/anterior aba                 |

### NvimTree (Explorador de Arquivos)

| Atalho       | Ação                                  |
| ------------ | ------------------------------------- |
| `<leader>ee` | Abrir/Fechar o explorador de arquivos |
| `<leader>ef` | Focar o explorador no arquivo atual   |
| `<leader>ec` | Fechar todas as pastas no explorador  |
| `<leader>er` | Atualizar o explorador                |

### Telescope (Busca)

| Atalho       | Ação                                     |
| ------------ | ---------------------------------------- |
| `<leader>ff` | Encontrar arquivos                       |
| `<leader>fr` | Encontrar arquivos recentes              |
| `<leader>fs` | Buscar texto no projeto (live_grep)      |
| `<leader>fc` | Buscar a palavra sob o cursor no projeto |
| `<leader>ft` | Encontrar TODOs, FIXMEs, etc.            |
| `<leader>fk` | Buscar atalhos de teclado                |

### LSP (Linguagem)

| Atalho       | Ação                                     |
| ------------ | ---------------------------------------- |
| `gd`         | Ir para a definição                      |
| `gD`         | Ir para a declaração                     |
| `gi`         | Ir para a implementação                  |
| `gR`         | Mostrar referências                      |
| `K`          | Mostrar documentação (hover)             |
| `<leader>ca` | Ver ações de código disponíveis          |
| `<leader>rn` | Renomear símbolo                         |
| `<leader>d`  | Mostrar diagnóstico da linha (flutuante) |
| `]d` / `[d`  | Ir para o próximo/anterior diagnóstico   |

### Trouble (Diagnósticos)

| Atalho       | Ação                                         |
| ------------ | -------------------------------------------- |
| `<leader>xw` | Abrir/Fechar diagnósticos do workspace       |
| `<leader>xd` | Abrir/Fechar diagnósticos do documento atual |
| `<leader>xt` | Abrir/Fechar lista de TODOs                  |

### Git

| Atalho       | Ação                                         |
| ------------ | -------------------------------------------- |
| `<leader>lg` | Abrir interface do `LazyGit`                 |
| `<leader>hs` | Adicionar "hunk" atual ao stage (`gitsigns`) |
| `<leader>hr` | Resetar "hunk" atual (`gitsigns`)            |
| `]h` / `[h`  | Navegar para o próximo/anterior "hunk"       |
| `<leader>hp` | Pré-visualizar "hunk"                        |
| `<leader>hb` | Ver `git blame` da linha                     |

## 🚀 Instalação

1.  Faça um backup de sua configuração atual do Neovim (`~/.config/nvim`).
2.  Clone este repositório para a sua pasta de configuração:
    ```sh
    git clone https://github.com/seu-usuario/seu-repo.git ~/.config/nvim
    ```
3.  Inicie o Neovim. O `lazy.nvim` irá instalar todos os plugins automaticamente.

