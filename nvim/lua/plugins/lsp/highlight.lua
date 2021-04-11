local setup = function()
    vim.api.nvim_exec(
        [[
                hi default link LspReferenceRead  CursorColumn
                hi default link LspReferenceText  CursorColumn
                hi default link lspreferencewrite  CursorColumn
                augroup lsp_document_highlight
                  autocmd! * <buffer>
                  autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
        false
    )
end

return {setup = setup}
