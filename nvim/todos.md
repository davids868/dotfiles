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
