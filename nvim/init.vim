syntax on

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
set autoread                    " enables aoto reading of files edited outside vim
" set cursorline
set synmaxcol=150
set ttyfast

" highlight search results
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

set ttimeout
set ttimeoutlen=100
set timeoutlen=3000

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=100
highlight ColorColumn ctermbg=0 guibg=lightgrey

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END

" always show signcolumns
set signcolumn=yes

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'ap/vim-css-color'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi'
Plug 'chiedo/vim-case-convert'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-commentary'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'svermeulen/vim-cutlass'
Plug 'elmcast/elm-vim'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }
Plug 'jpalardy/vim-slime'
Plug 'thaerkh/vim-workspace'
Plug 'jiangmiao/auto-pairs'

"-----------------
" Experimental
"-----------------
" Plug 'puremourning/vimspector'
Plug 'Yggdroot/indentLine'
" Plug 'antoinemadec/coc-fzf'
Plug 'vim-test/vim-test'
Plug 'mattn/calendar-vim'
Plug 'sbdchd/neoformat'

Plug 'airblade/vim-gitgutter'
" Plug 'lewis6991/gitsigns.nvim'

Plug 'liuchengxu/vista.vim'
" Plug 'psliwka/vim-smoothie'
" Plug 'vim-utils/vim-man'
" Plug 'tpope/vim-obsession'
" Plug 'dbeniamine/cheat.sh-vim'
" Plug 'svermeulen/vim-easyclip'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'vn-ki/coc-clap'
" Plug 'metakirby5/codi.vim'
" " Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }

" Plug 'nvim-lua/completion-nvim'
" Plug 'nvim-lua/lsp_extensions.nvim'
" Plug 'alexaandru/nvim-lspupdate'
Plug 'hrsh7th/nvim-compe'

Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'junegunn/gv.vim'

" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'tjdevries/express_line.nvim'

Plug 'Dualspc/spaceodyssey'
Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}

"-----------------
" Styles
"-----------------
" Plug 'gruvbox-community/gruvbox'
" Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'

" Plug 'colepeters/spacemacs-theme.vim'
Plug 'lifepillar/vim-gruvbox8'
" Plug 'joshdick/onedark.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'flazz/vim-colorschemes'
Plug 'sainnhe/sonokai'

" Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'kyazdani42/nvim-web-devicons' " lua
Plug 'ryanoasis/vim-devicons' " Last to load

call plug#end()

" let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
" let g:gruvbox_invert_selection='0'

set background=dark
colorscheme gruvbox8_hard

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25

" elm format
let g:elm_format_autosave = 1

" workspace
let g:workspace_session_directory = $HOME . '/.config/nvim/session/'
let g:workspace_session_disable_on_args = 1
let g:workspace_persist_undo_history = 0
let g:workspace_autosave = 0
let g:workspace_autosave_untrailspaces = 0
let g:workspace_autosave_untrailtabs = 0
let g:workspace_autosave_always = 0

set showtabline=2
set laststatus=2
lua require('plugins.galaxyline')

" scrolling
nnoremap <C-d> 20j
nnoremap <C-u> 20k

" Tab actions
nnoremap <C-t> :tabnew<CR>
nnoremap <C-x> :tabclose<CR>

" Begging/End of line
noremap H 0
noremap L $

" Better Esc mappings
inoremap jk <Esc>
inoremap kj <Esc>
map <C-c> <Esc>

nnoremap ; :

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
" noremap x "_x
" noremap X "_x

" replace
" nnoremap <silent>*s :let @/='\<'.expand('<cword>').'\>'<CR>cgn

" multiple cursors
"let g:multi_cursor_use_default_mapping=0
"let g:multi_cursor_start_word_key      = '<C-n>'
"let g:multi_cursor_start_word_key      = '<C-n>'
"let g:multi_cursor_quit_key            = '<Esc>'
map Q q
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

nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <Leader><CR> :source ~/.config/nvim/init.vim<CR>

" Open init.vim in new tab
nnoremap <Leader>, :tabnew ~/.config/nvim/init.vim<CR>

" Goyo
" nmap <Leader>z :Goyo<CR>
nmap <Leader>z :MaximizerToggle<CR>

" run las used macro on selected lines
vnoremap @@ :normal @@<CR>

" gitgutter
let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_map_keys = 0

" Coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-elixir',
  \ 'coc-solargraph',
  \ 'coc-html',
  \ 'coc-explorer',
  \ 'coc-yank',
  \ 'coc-tabnine',
  \ 'coc-stylelint',
  \ 'coc-css',
  \ 'coc-go',
  \ 'coc-lua',
  \ 'coc-jedi',
  \ 'coc-pyright',
  \ ]

nnoremap <leader>cr :CocRestart<CR>
nmap <Leader>n :CocCommand explorer<CR>
augroup highlight_cursor
    autocmd!
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end
noremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
endif

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-declaration)
nmap <leader>gt <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references-used)
nmap <F2> <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>. :CocFix<cr>
nmap <silent> <leader>a <Plug>(coc-codeaction-cursor)
vmap <silent> <leader>a <Plug>(coc-codeaction-selected)

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
vnoremap <silent> <leader><tab> :exe "tabn ".g:lasttab<cr>

" restore closed tab
" noremap <leader>T :tabnew<bar>:Buffers<CR><CR>

" Sweet Sweet FuGITive
let g:fugitive_gitlab_domains = ['https://gitlab.eu-west-1.mgmt.onfido.xyz/']

map <leader>ge :GBrowse<CR>
nmap <leader>dm :Gvdiffsplit origin/master<CR>
nmap <leader>dl :diffget //3<CR>
nmap <leader>dh :diffget //2<CR>
nmap <leader>gs :tab G<CR>
nmap <leader>gb :Git blame<CR>
nmap <leader>gl :Git pull<CR>
nmap <leader>gpp :Git push
nmap <leader>gpf :Git push -f
nmap <leader>gpu :Git push -u origin HEAD
nmap <leader>go :GBranches<CR>
nmap <leader>gc :Commits<CR>
nnoremap <leader>gh :GitGutterPreviewHunk<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup trim_whitespaces
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup end

" treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}
local parser_config = require"nvim-treesitter.parsers".get_parser_configs()
EOF

augroup customfiletypes
  autocmd!
  autocmd BufNewFile,BufRead *.mypy-testing setf python
augroup end

" indentLine
let g:indentLine_char = '¦'
let g:indentLine_enabled = 0

" let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" slime
let g:slime_target = "tmux"

" firenvim
let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }
au BufEnter gitlab* set filetype=markdown
if exists('g:started_by_firenvim')
  set laststatus=0
  set showtabline=1
endif

let g:vimwiki_key_mappings = { 'table_mappings': 0 }
augroup vimwiki
    autocmd!
    au FileType calendar set nornu signcolumn=no
    au FileType vimwiki inoremap <silent> <buffer> <expr> <CR> pumvisible() ? "\<C-y>" : "<Esc>:VimwikiReturn 1 5<CR>"
    " au FileType vimwiki inoremap <silent> <buffer> <expr> <S-CR> pumvisible() ? "\<S-C-y>" : "<Esc>:VimwikiReturn 2 2<CR>"
    au FileType vimwiki set synmaxcol=400
    au FileType vimwiki let g:vista_echo_cursor=0
augroup END


" set nocompatible
" filetype plugin on
" let g:vimwiki_list = [{'auto_diary_index': 1}]

" Functions
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

function! ToggleRelativeLineNumbers()
  set relativenumber!
  if &relativenumber
    echo "Relative line numbers: ON"
  else
    echo "Relative line numbers: OFF"
  endif
endfunction

" let g:profiling = 0
" function! ToggleProfiling()
"   if g:profiling
"     let g:profiling = 1
"     profile start profiling.log
"     profile file *
"     profile func *
"     echo "Profiling ON"
"   else
"     let g:profiling = 0
"     profile stop
"     echo "Profiling OFF"
"   endif
" endfunction
" command! Profiling call ToggleProfiling()

" Custom commands
command! SpellCheck call ToggleSpellCheck()
command! ToggleRelativeLineNumbers call ToggleRelativeLineNumbers()
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Change the color
highlight CodiVirtualText guifg=cyan
let g:codi#virtual_text_prefix = "❯ "
