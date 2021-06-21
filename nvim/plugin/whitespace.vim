if exists('g:loaded_plugin_whitespace')
	finish
endif
let g:loaded_plugin_whitespace = 1

command! TrimWhitespace call TrimWhitespace()

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup trim_whitespaces
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup end
