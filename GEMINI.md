# Gemini - Guia para Interagir com esta Configuração do Neovim

Este documento serve como um guia para uma IA como você entender e interagir com esta configuração do Neovim.

## Visão Geral do Projeto

Esta é uma configuração pessoal do Neovim baseada no LazyVim. O objetivo é ter um ambiente de desenvolvimento leve, rápido e produtivo.

## Estrutura

A configuração está estruturada da seguinte forma:

- `init.lua`: O ponto de entrada principal da configuração. Ele simplesmente carrega o `lazy.nvim`.
- `lua/config/lazy.lua`: O arquivo de configuração principal do `lazy.nvim`. Ele define de onde carregar os plugins.
- `lua/plugins/`: O diretório que contém todos os plugins personalizados. Cada arquivo `.lua` neste diretório representa um plugin ou um conjunto de plugins.
- `lua/config/`: Este diretório contém as configurações principais do Neovim, como opções, autocmds e keymaps.
  - `options.lua`: Define as opções do editor.
  - `autocmds.lua`: Define os autocmds.
  - `keymaps.lua`: Define os atalhos de teclado.

## Plugins

- **Adicionar um Plugin:** Para adicionar um novo plugin, crie um novo arquivo `.lua` em `lua/plugins/` com a especificação do plugin.
- **Remover um Plugin:** Para remover um plugin, simplesmente exclua o arquivo `.lua` correspondente em `lua/plugins/`.
- **Modificar um Plugin:** Para modificar a configuração de um plugin, edite o arquivo `.lua` correspondente em `lua/plugins/`.

## Tema

O tema é definido no arquivo `lua/plugins/theme.lua`. Para alterar o tema, edite este arquivo e altere o `colorscheme`.

**Importante:** O script `omarchy-theme-hotreload.lua` depende do arquivo `lua/plugins/theme.lua`. Se você remover este arquivo, o script de hot-reload irá falhar.

## Keymaps

Os atalhos de teclado personalizados são definidos em `lua/config/keymaps.lua`. Use a função `vim.keymap.set` para adicionar ou modificar os atalhos.

## Opções

As opções do editor são definidas em `lua/config/options.lua`. Use `vim.opt` para definir as opções.

## Committing de Alterações

Ao fazer alterações nesta configuração, por favor, siga as convenções de commit existentes.
