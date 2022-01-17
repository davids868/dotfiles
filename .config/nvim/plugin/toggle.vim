if exists('g:toggle')
	finish
endif
let g:loaded_plugin_toggle = 1

" Functions
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck: ON"
  else
    echo "Spellcheck: OFF"
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


" Custom commands
command! SpellCheck call ToggleSpellCheck()
command! RelativeLineNumbers call ToggleRelativeLineNumbers()

