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

function! ToggleLastStatus()
  if &laststatus == 2
    set laststatus=3
    echo "Global status line: ON"
  else
    set laststatus=2
    echo "Global status line: OFF"
  endif
endfunction



" Custom commands
command! SpellCheck call ToggleSpellCheck()
command! RelativeLineNumbers call ToggleRelativeLineNumbers()
command! LastStatus call ToggleLastStatus()

