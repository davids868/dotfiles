## LUA
* migrate to packer

## Figure out if these are needed
```vim
let g:far#enable_undo=1
if executable('rg')
    let g:far#source='rg'
    let g:rg_derive_root='true'
endif
let g:far#enable_undo=1
```

```vim
if isdirectory($PWD .'/node_modules')
    let $PATH .= ':' . $PWD . '/node_modules/.bin'
endif
```

```vim
let g:mkdp_command_for_global = 1
command! Preview :MarkdownPreview
```

```vim
let g:maximizer_restore_on_winleave = 1
nnoremap <silent><Leader>z :MaximizerToggle<CR>
vnoremap <silent><Leader>z :MaximizerToggle<CR>gv
```

```vim
call plug#begin('~/.vim/plugged')

"Plug 'editorconfig/editorconfig-vim'
"Plug 'mattn/emmet-vim'
"Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'dstein64/vim-startuptime'

"-----------------
" LSP + Completion
"-----------------
" Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
"Plug 'folke/lsp-colors.nvim'

"-----------------
"  Fixing
"-----------------
" Plug 'wellle/context.vim'
" Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
"

"-----------------
"  Compare
"-----------------
"Plug 'brooth/far.vim'
"Plug 'windwp/nvim-spectre'

"-----------------
" Fennel
"-----------------
" Plug 'Olical/conjure', {'tag': 'v4.17.0'}
"Plug 'Olical/aniseed', { 'tag': 'v3.16.0' }
"Plug 'bakpakin/fennel.vim'
" Plug 'elkowar/antifennel-nvim'
" Plug 'tami5/compe-conjure'

"-----------------
" Test
"-----------------
" dap
" Plug 'puremourning/vimspector'
" Plug 'vim-utils/vim-man'
" Plug 'metakirby5/codi.vim'


call plug#end()

```

## Fennel
```vim
let g:aniseed#env = { "module": "fnl.init", "output": "/lua/fnl" }
```
