local g = vim.g
local cmd = vim.cmd

-- Vim Wiki
--  let g:vimwiki_global_ext = 0
--  let g:vimwiki_list = [{'auto_diary_index': 1}]
g.vimwiki_key_mappings = {table_mappings = 0}
g.vimwiki_list = {{path = "~/vimwiki/"}, {path = "~/md_wiki/", syntax = "markdown", ext = ".md"}}
g.vimwiki_ext2syntax = {[".md"] = "markdown", [".markdown"] = "markdown"}
g.vimwiki_markdown_link_ext = 1

cmd(
    [[
augroup vimwiki
    autocmd!
    au FileType calendar set nornu signcolumn=no
    au FileType vimwiki inoremap <silent> <buffer> <expr> <CR> pumvisible() ? "\<C-y>" : "<Esc>:VimwikiReturn 1 5<CR>"
    au FileType vimwiki,md set synmaxcol=400
    au FileType vimwiki let g:vista_echo_cursor=0
augroup END
]]
)
