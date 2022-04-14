local setup = function()
	vim.api.nvim_exec(
		[[
                hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
                hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
                hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
                augroup lsp_document_highlight
                  autocmd! * <buffer>
                  autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
		false
	)
end

return { setup = setup }
