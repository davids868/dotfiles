require "plugins.plugins"

local install_plugins = function()
    vim.cmd(
        [[
  call plug#begin('~/.vim/plugged')

Plug 'mbbill/undotree'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi'
Plug 'chiedo/vim-case-convert'
Plug 'szw/vim-maximizer'
Plug 'svermeulen/vim-cutlass'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }
Plug 'jpalardy/vim-slime'
Plug 'thaerkh/vim-workspace'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'hoob3rt/lualine.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dstein64/vim-startuptime'

"-----------------
" required by other plugins
"-----------------
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

"-----------------
" LSP + Completion
"-----------------
Plug 'hrsh7th/nvim-compe'
" Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
Plug 'onsails/lspkind-nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'folke/lsp-trouble.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'folke/lsp-colors.nvim'

"-----------------
"  Fixing
"-----------------
"Plug 'kyazdani42/nvim-tree.lua'
" Plug 'wellle/context.vim'
" Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
"

"-----------------
"  Compare
"-----------------
Plug 'brooth/far.vim'
Plug 'windwp/nvim-spectre'

"-----------------
" Experimental
"-----------------
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/calendar-vim'
Plug 'reedes/vim-pencil'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['vimwiki', 'markdown', 'vim-plug']}
Plug 'jparise/vim-graphql'
Plug 'rafcamlet/nvim-luapad'
Plug 'sunjon/Shade.nvim'
" Plug 'kevinhwang91/nvim-hlslens'

"-----------------
" Fennel
"-----------------
" Plug 'Olical/conjure', {'tag': 'v4.17.0'}
Plug 'Olical/aniseed', { 'tag': 'v3.16.0' }
Plug 'bakpakin/fennel.vim'
" Plug 'elkowar/antifennel-nvim'
" Plug 'tami5/compe-conjure'

"-----------------
" Test
"-----------------
" dap
" Plug 'puremourning/vimspector'
" Plug 'vim-utils/vim-man'
" Plug 'metakirby5/codi.vim'

"-----------------
" Styles
"-----------------


call plug#end()
  ]]
    )
end

local load_plugins = function()
    -- require("plugins.icons")
    -- require("plugins.galaxyline")
    -- require("plugins.lualine")
    -- require("plugins.treesitter")
    require("plugins.compe")
    require("plugins.lsp")
    -- require("plugins.git")
    require("plugins.telescope")
    -- require("plugins.symbol-outline")
    -- require("plugins.tree")
    require("plugins.sessions")
    -- require("plugins.diffview")
    require("plugins.trouble")
    -- require("plugins.todo-comments")
    require("plugins.format")
    require("plugins.markdown")
    require("plugins.firenvim")
    -- require("plugins.clap")
    -- require("zen-mode").setup()
end

-- disable default plugins
local disable_distribution_plugins = function()
    vim.g.loaded_gzip = 1
    vim.g.loaded_tar = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_zip = 1
    vim.g.loaded_zipPlugin = 1
    vim.g.loaded_getscript = 1
    vim.g.loaded_getscriptPlugin = 1
    vim.g.loaded_vimball = 1
    vim.g.loaded_vimballPlugin = 1
    vim.g.loaded_matchit = 1
    vim.g.loaded_matchparen = 1
    vim.g.loaded_2html_plugin = 1
    vim.g.loaded_logiPat = 1
    vim.g.loaded_rrhelper = 1
    -- vim.g.loaded_netrw = 1 -- needed for GBrowse
    -- vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrwSettings = 1
    vim.g.loaded_netrwFileHandlers = 1
end

install_plugins()
disable_distribution_plugins()
load_plugins()
