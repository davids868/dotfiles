if exists('g:loaded_plugin_url') || !has('macunix')
	finish
endif
let g:loaded_plugin_url = 1

function! OpenURLUnderCursor()
  let s:uri = matchstr(getline('.'), '[a-z]*:\/\/[^ >,;()]*')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '".s:uri."'"
    :redraw!
  endif
endfunction

nnoremap gx :call OpenURLUnderCursor()<CR>
