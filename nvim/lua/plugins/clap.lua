local nnoremap = require("utils.mappers").nnoremap
local g = vim.g
local cmd = vim.cmd

-- g.clap_layout = { relative= 'editor', width= '45%', col= '5%' }
g.clap_insert_mode_only = true
g.clap_theme = "atom_dark"
g.clap_provider_yanks_max_entries = 300
g.clap_provider_yanks_history = "~/.clap_yanks.history"
g.clap_layout = {relative = "editor", width = "80%", col = "10%", height = "30%", row = "10%"}
g.clap_preview_direction = "UD"

nnoremap {"<leader>L", ":Neoformat<CR>"}

cmd(
    [[
augroup clap
  autocmd!
  autocmd FileType clap_input call compe#setup({'enabled': v:false}, 0)
  autocmd FileType clap_input inoremap <silent> <buffer> jk jk
  autocmd FileType clap_input inoremap <silent> <buffer> kj kj
  autocmd FileType clap_input inoremap <silent> <buffer> <C-n> <C-R>=clap#navigation#linewise('down')<CR>
  autocmd FileType clap_input inoremap <silent> <buffer> <C-p> <C-R>=clap#navigation#linewise('up')<CR>
augroup END
]]
)

nnoremap {"<Leader>cl", ":Clap<CR>"}
nnoremap {"<Leader>G", ":Clap grep2<CR>"}
nnoremap {"<Leader>y", ":Clap yanks<CR>"}
