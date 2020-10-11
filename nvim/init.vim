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
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 100)
augroup END

" always show signcolumns
set signcolumn=yes

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
" Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'stsewd/fzf-checkout.vim'
" Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'mhinz/vim-startify'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'psliwka/vim-smoothie'
" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
" Plug 'metakirby5/codi.vim'

Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'itchyny/lightline.vim'
Plug 'flazz/vim-colorschemes'
" Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}

" devicons sould be the last to loaded
Plug 'ryanoasis/vim-devicons'

call plug#end()

let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

" --- The Greatest plugin of all time.  I am not bias
" let g:vim_be_good_floating = 0
colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ranger_replace_netrw = 1 "// open ranger when vim open a directory

let loaded_matchparen = 1
let mapleader = " "

let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25

" vim airline/lightline
set showtabline=2
" let g:airline#extensions#tabline#enabled = 1
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" startify
nnoremap <Leader>s :Startify<CR>
let g:webdevicons_enable_startify = 1
let g:startify_change_to_dir = 1
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_session_persistence = 1
let g:startify_session_before_save = [
        \ 'echo "Cleaning up before saving.."',
        \ ]
let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ ]
          " \ { 'type': 'files',     'header': ['   MRU']            },
          " \ { 'type': 'commands',  'header': ['   Commands']       },

let g:startify_bookmarks = [
            \ { 'c': '~/.config' },
            \ { 'd': '~/dev' },
            \ { '1': '~/dev/document-checks' },
            \ { '2': '~/dev/docupedia' },
            \ { '3': '~/dev/docupedia-js' },
            \ { '4': '~/dev/docupedia-data-scripts' },
            \ ]

" Tab actions
nnoremap <C-t> :tabnew<CR>
nnoremap <C-x> :tabclose<CR>

" Better Esc mappings
inoremap jk <Esc>
inoremap kj <Esc>
map <C-c> <Esc>

" nnoremap <silent> <TAB> :tabnext<CR>
" nnoremap <silent> <S-TAB> :tabprevious<CR>
" nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>

" search
nnoremap <leader>F :Rg<space>
" nnoremap <leader>F :Rg <C-R>=expand("<cword>")<CR><CR>
vnoremap <leader>F :Rg '<,'><CR>
nnoremap <Leader>f :BLines<CR>
" nnoremap <leader>*f :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>p :GFiles<CR>
nnoremap <leader>P :Commands<CR>
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>r :History<CR>
nnoremap <Leader>; :History:<CR>

" replace
" nnoremap <silent>*s :let @/='\<'.expand('<cword>').'\>'<CR>cgn

" multiple cursors
"let g:multi_cursor_use_default_mapping=0
"let g:multi_cursor_start_word_key      = '<C-n>'
"let g:multi_cursor_start_word_key      = '<C-n>'
"let g:multi_cursor_quit_key            = '<Esc>'

map <leader>q :qa<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

" Use alt + hjkl to resize windows
nnoremap <silent> <M-j> :resize -2<CR>
nnoremap <silent> <M-k> :resize +2<CR>
nnoremap <silent> <M-h> :vertical resize -3<CR>
nnoremap <silent> <M-l> :vertical resize +3<CR>

inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k

" Increase/Decrease
nnoremap + <C-a>
nnoremap _ <C-x>

" Better indentation
vnoremap < <gv
vnoremap > >gv
nnoremap < <<
nnoremap > >>

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader><CR> :source ~/.config/nvim/init.vim<CR>

" Open init.vim in new tab
nnoremap <Leader>, :tabnew ~/.config/nvim/init.vim<CR>

" coc explorerc
nmap <Leader>n :CocCommand explorer<CR>

" Goyo
nmap <Leader>z :Goyo<CR>

" run las used macro on selected lines
vnoremap @@ :normal @@<CR>

" gitgutter
let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_map_keys = 0

" commenter
" let g:NERDSpaceDelims = 1

" nnoremap <silent><leader>/ <plug>NERDCommenterToggle

" Coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-elixir',
  \ 'coc-solargraph',
  \ 'coc-html',
  \ 'coc-explorer'
  \ ]

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
endif

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
" set updatetime=300


function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" inoremap <silent><expr> <C-space> coc#refresh()

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>. :CocFix<cr>
nnoremap <leader>cr :CocRestart

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
nnoremap <silent> <leader>t :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <leader>t :exe "tabn ".g:lasttab<cr>

" Sweet Sweet FuGITive
nmap <leader>gl :diffget //3<CR>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gs :tab G<CR>
nmap <leader>gb :Git blame<CR>
nmap <leader>gp :Git push
nmap <leader>go :GCheckout<CR>
nmap <leader>gc :Commits<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun


augroup trim_whitespaces
  autocmd BufWritePre * :call TrimWhitespace()
augroup end

" fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 1 } }
let g:fzf_buffers_jump = 1

" VimWiki
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

" Custom commands
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! SpellCheck call ToggleSpellCheck()

" Change the color
highlight CodiVirtualText guifg=cyan
let g:codi#virtual_text_prefix = "❯ "
