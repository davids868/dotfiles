set mouse=a
set guicursor=
set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set ignorecase
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set clipboard=unnamedplus
set noshowmode                  " removes  --INSERT--
set autoread                    " enables aoto reading of files edited outside vim" syntax on
set synmaxcol=150
set ttyfast
set nocompatible

augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

set ttimeout
set ttimeoutlen=100
set timeoutlen=2000

set cmdheight=1

set updatetime=50

highlight ColorColumn ctermbg=0 guibg=lightgrey
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=100

let mapleader = " "

" filetype plugin on

" highlight ColorColumn ctermbg=0 guibg=lightgrey

"call plug#begin('~/.vim/plugged')

"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-rhubarb'
"Plug 'shumphrey/fugitive-gitlab.vim'
"Plug 'mbbill/undotree'
"Plug 'ap/vim-css-color'
"Plug 'editorconfig/editorconfig-vim'
"Plug 'mattn/emmet-vim'
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'vimwiki/vimwiki'
"Plug 'tpope/vim-surround'
"Plug 'mg979/vim-visual-multi'
"Plug 'chiedo/vim-case-convert'
"Plug 'szw/vim-maximizer'
"Plug 'tpope/vim-commentary'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'svermeulen/vim-cutlass'
"Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }
"Plug 'jpalardy/vim-slime'
"Plug 'thaerkh/vim-workspace'
"Plug 'lewis6991/gitsigns.nvim'
"Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
"Plug 'kdheepak/lazygit.nvim'
"Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}
"Plug 'hoob3rt/lualine.nvim'
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'sbdchd/neoformat'
"Plug 'tpope/vim-repeat'
"Plug 'kevinhwang91/nvim-bqf'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'folke/todo-comments.nvim'
"Plug 'sindrets/diffview.nvim'
"Plug 'dstein64/vim-startuptime'
"Plug 'junegunn/gv.vim'

""-----------------
"" required by other plugins
""-----------------
"Plug 'nvim-lua/popup.nvim'
"Plug 'nvim-lua/plenary.nvim'

""-----------------
"" LSP + Completion
""-----------------
"Plug 'hrsh7th/nvim-compe'
"" Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
"Plug 'onsails/lspkind-nvim'
"Plug 'neovim/nvim-lspconfig'
"Plug 'glepnir/lspsaga.nvim'
"Plug 'folke/lsp-trouble.nvim'
"Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
"Plug 'folke/lsp-colors.nvim'
"Plug 'windwp/nvim-ts-autotag'

""-----------------
""  Fixing
""-----------------
"Plug 'kyazdani42/nvim-tree.lua'
"" Plug 'wellle/context.vim'
"" Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
""

""-----------------
""  Compare
""-----------------
"Plug 'brooth/far.vim'
"Plug 'windwp/nvim-spectre'

""-----------------
"" Experimental
""-----------------
"Plug 'jiangmiao/auto-pairs'
"Plug 'mattn/calendar-vim'
"Plug 'reedes/vim-pencil'
"Plug 'plasticboy/vim-markdown'
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['vimwiki', 'markdown', 'vim-plug']}
"Plug 'jparise/vim-graphql'
"Plug 'simrat39/symbols-outline.nvim'
"Plug 'folke/zen-mode.nvim'
"Plug 'rafcamlet/nvim-luapad'
"Plug 'sunjon/Shade.nvim'
"" Plug 'kevinhwang91/nvim-hlslens'

""-----------------
"" Fennel
""-----------------
"" Plug 'Olical/conjure', {'tag': 'v4.17.0'}
"Plug 'Olical/aniseed', { 'tag': 'v3.16.0' }
"Plug 'bakpakin/fennel.vim'
"" Plug 'elkowar/antifennel-nvim'
"" Plug 'tami5/compe-conjure'

""-----------------
"" Test
""-----------------
"" dap
"" Plug 'puremourning/vimspector'
"" Plug 'vim-utils/vim-man'
"" Plug 'metakirby5/codi.vim'

""-----------------
"" Styles
""-----------------
"Plug 'sainnhe/gruvbox-material'
"Plug 'npxbr/gruvbox.nvim'
"Plug 'eddyekofo94/gruvbox-flat.nvim'

"Plug 'tjdevries/colorbuddy.vim'
"Plug 'tjdevries/gruvbuddy.nvim'
""
"Plug 'shaunsingh/nord.nvim'
"Plug 'ayu-theme/ayu-vim'
"Plug 'rktjmp/lush.nvim'
"Plug 'drewtempelmeyer/palenight.vim'
"Plug 'flazz/vim-colorschemes'
"Plug 'sainnhe/sonokai'
"Plug 'Dualspc/spaceodyssey'
"Plug 'sonph/onehalf', { 'rtp': 'vim' }
"Plug 'folke/tokyonight.nvim'
"Plug 'glepnir/zephyr-nvim'
"Plug 'rafamadriz/neon'

"Plug 'kyazdani42/nvim-web-devicons'

"call plug#end()

" lua require('init')

" let g:netrw_browse_split = 2
" let g:vrfr_rg = 'true'
" let g:netrw_banner = 0
" let g:netrw_winsize = 25

" let g:far#enable_undo=1
" if executable('rg')
"     let g:far#source='rg'
"     let g:rg_derive_root='true'
" endif
" let g:far#enable_undo=1

" workspace
" let g:workspace_session_directory = $HOME . '/.config/nvim/session/'
" let g:workspace_session_disable_on_args = 1
" let g:workspace_persist_undo_history = 0
" let g:workspace_autosave = 0
" let g:workspace_autosave_untrailspaces = 0
" let g:workspace_autosave_untrailtabs = 0
" let g:workspace_autosave_always = 0

 " scrolling
 nnoremap <C-d> 20j
 nnoremap <C-u> 20k

 " Tab actions
 nnoremap <leader>tn :tabnew<CR>
 nnoremap <leader>tq :tabclose<CR>

 " visual search
 vnoremap / y/<C-r>0

 " Begging/End of line
 noremap H 0
 noremap L $

 " Better Esc mappings
 inoremap jk <Esc>
 inoremap kj <Esc>
 map <C-c> <Esc>

 " Yanks
 nnoremap Y y$
 nnoremap <leader>Y ggyG<C-o>

 " Move code blocks
 vnoremap J :m '>+1<CR>gv=gv
 vnoremap K :m '<-2<CR>gv=gv

 " Better clipboard, adds m for move
 nnoremap gm m
 nnoremap m d
 xnoremap m d
 nnoremap mm dd
 nnoremap M D
 vnoremap p "_dP
 vnoremap P "_dp

 " map Q q
 nnoremap <leader>q :q<CR>
 nnoremap <leader>Q :qa<CR>
 nnoremap <C-s> :w<CR>
 inoremap <C-s> <Esc>:w<CR>
 nnoremap <leader>e :e<CR>

 " Use alt + hjkl to resize windows
 nnoremap <silent> <M-j> :resize -2<CR>
 nnoremap <silent> <M-k> :resize +2<CR>
 nnoremap <silent> <M-h> :vertical resize -10<CR>
 nnoremap <silent> <M-l> :vertical resize +10<CR>

 " Increase/Decrease
 nnoremap + <C-a>
 nnoremap _ <C-x>

 " Better indentation
 vnoremap < <gv
 vnoremap > >gv
 nnoremap < <<
 nnoremap > >>

 " Better incsearch
 cnoremap <c-j> <c-g>
 cnoremap <c-k> <c-t>

 " navigating command mode
 cnoremap <c-h> <left>
 cnoremap <c-l> <right>

 nnoremap <Leader><CR> :source ~/.config/vim/.vimrc<CR>

" nnoremap <leader>u :UndotreeToggle<CR>

" maximizer
" let g:maximizer_restore_on_winleave = 1
" nnoremap <silent><Leader>z :MaximizerToggle<CR>
" vnoremap <silent><Leader>z :MaximizerToggle<CR>gv

" " run last used macro on selected lines
" vnoremap @@ :normal @@<CR>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <leader><tab> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <leader><tab> <esc>:exe "tabn ".g:lasttab<cr>

" " git
" let g:fugitive_gitlab_domains = ['https://gitlab.eu-west-1.mgmt.onfido.xyz/']

" map <leader>ge :GBrowse<CR>
" map <leader>gy :GBrowse!<CR>
" nmap <leader>dm :Gvdiffsplit origin/master<CR>
" nmap <leader>dv :DiffviewToggle<CR>
" nmap <leader>dl :diffget //3<CR>
" nmap <leader>dh :diffget //2<CR>
" nmap <leader>gs :tab G<CR>
" nmap <leader>gb :Git blame<CR>
" nmap <leader>gl :Git pull<CR>
" nmap <leader>gpp :Git push
" nmap <leader>gpf :Git push -f
" nmap <leader>gpu :Git push -u origin HEAD
" nnoremap <silent><leader>gc :GV<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup trim_whitespaces
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup end

" augroup customfiletypes
"   autocmd!
"   autocmd BufNewFile,BufRead *.mypy-testing setf python
"   autocmd FileType tf set formatprg=terraform
" augroup end

" slime
" let g:slime_target = "tmux"

" firenvim
" let g:firenvim_config = {
"     \ 'globalSettings': {
"         \ 'alt': 'all',
"     \  },
"     \ 'localSettings': {
"         \ '.*': {
"             \ 'cmdline': 'neovim',
"             \ 'priority': 0,
"             \ 'selector': 'textarea',
"             \ 'takeover': 'never',
"         \ },
"     \ }
" \ }
" au BufEnter gitlab* set filetype=markdown
" if exists('g:started_by_firenvim')
"   set laststatus=0
"   set showtabline=1
" endif

" " WIKI
" augroup vimwiki
"     autocmd!
"     au FileType calendar set nornu signcolumn=no
"     au FileType vimwiki inoremap <silent> <buffer> <expr> <CR> pumvisible() ? "\<C-y>" : "<Esc>:VimwikiReturn 1 5<CR>"
"     au FileType vimwiki,md set synmaxcol=400
"     au FileType vimwiki let g:vista_echo_cursor=0
" augroup END

" " let g:vimwiki_global_ext = 0
" let g:vimwiki_key_mappings = { 'table_mappings': 0 }
" " let g:vimwiki_list = [{'auto_diary_index': 1}]
" let g:vimwiki_list = [{'path': '~/vimwiki/'},
"       \{'path': '~/md_wiki/', 'syntax': 'markdown', 'ext': '.md'}]
" let g:vimwiki_ext2syntax = { '.md': 'markdown','.markdown': 'markdown' }
" let g:vimwiki_markdown_link_ext = 1


" " Functions
" function! ToggleSpellCheck()
"   set spell!
"   if &spell
"     echo "Spellcheck ON"
"   else
"     echo "Spellcheck OFF"
"   endif
" endfunction

" function! ToggleRelativeLineNumbers()
"   set relativenumber!
"   if &relativenumber
"     echo "Relative line numbers: ON"
"   else
"     echo "Relative line numbers: OFF"
"   endif
" endfunction


" " Custom commands
" command! SpellCheck call ToggleSpellCheck()
" command! DiffviewToggle call DiffviewToggle()

" clap
" let g:clap_layout = { 'relative': 'editor', 'width': '45%', 'col': '5%' }
" let g:clap_insert_mode_only = v:true
" let g:clap_theme = 'atom_dark'
" let g:clap_provider_yanks_max_entries = 300
" let g:clap_provider_yanks_history = '~/.clap_yanks.history'
" let g:clap_layout = { 'relative': 'editor', 'width': '80%', 'col': '10%', 'height': '30%', 'row': '10%'}
" let g:clap_preview_direction = 'UD'

" augroup clap
"   autocmd!
"   autocmd FileType clap_input call compe#setup({'enabled': v:false}, 0)
"   autocmd FileType clap_input inoremap <silent> <buffer> jk jk
"   autocmd FileType clap_input inoremap <silent> <buffer> kj kj
"   autocmd FileType clap_input inoremap <silent> <buffer> <C-n> <C-R>=clap#navigation#linewise('down')<CR>
"   autocmd FileType clap_input inoremap <silent> <buffer> <C-p> <C-R>=clap#navigation#linewise('up')<CR>
" augroup END

" nnoremap <silent><Leader>cl :Clap<CR>
" nnoremap <silent><Leader>G :Clap grep2<CR>
" nnoremap <silent><Leader>y :Clap yanks<CR>

" nnoremap <leader>L :Neoformat<CR>
" let g:neoformat_enabled_ruby = ["rubocop"]
" let g:neoformat_enabled_yaml = ["prettier"]
" let g:neoformat_enabled_python = ["black"]

" nnoremap <silent> <leader>lg :LazyGit<CR>

" let g:mkdp_command_for_global = 1
" command! Preview :MarkdownPreview

" augroup fmt
"   autocmd!
"   let blacklist = ['ruby', 'yml', 'yaml']
"   autocmd BufWritePre * if index(blacklist, &ft) < 0 | Neoformat
" augroup END

" Fennel
" let g:aniseed#env = { "module": "fnl.init", "output": "/lua/fnl" }

" if has('macunix')
"   function! OpenURLUnderCursor()
"     let s:uri = matchstr(getline('.'), '[a-z]*:\/\/[^ >,;()]*')
"     let s:uri = shellescape(s:uri, 1)
"     if s:uri != ''
"       silent exec "!open '".s:uri."'"
"       :redraw!
"     endif
"   endfunction
"   nnoremap gx :call OpenURLUnderCursor()<CR>
" endif

" if isdirectory($PWD .'/node_modules')
"     let $PATH .= ':' . $PWD . '/node_modules/.bin'
" endif

