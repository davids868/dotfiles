require("lspkind").init()
require("lspsaga").init_lsp_saga {
    error_sign = "", -- 
    warn_sign = "",
    hint_sign = "",
    infor_sign = ""
}

require("plugins.lsp.tsserver")() -- also define the commands for lsp-utils so thy are available in telescope
local nvim_lsp = require("lspconfig")

vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

local telemmaper = require("plugins.telescope.mapping")
local nnoremap = require("utils.mappers").nnoremap
local vnoremap = require("utils.mappers").vnoremap

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits"
    }
}

local on_attach = function(client)
    if (client.name == "tsserver") then
        local ts_utils = require("nvim-lsp-ts-utils")
    -- ts_utils.setup_client(client)
    end

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    if client.resolved_capabilities.document_highlight then
        require("plugins.lsp.highlight").setup()
    end

    -- Mappings.
    telemmaper("n", "<leader>gr", "lsp_references")

    nnoremap {"gr", "vim.lsp.buf.references()"}
    nnoremap {"<leader>gd", "vim.lsp.buf.definition()"}
    nnoremap {"<leader>gt", "vim.lsp.buf.type_definition()"}
    nnoremap {"<leader>rn", "vim.lsp.buf.rename()"}
    -- nnoremap {"<leader>i", "vim.lsp.diagnostic.show_line_diagnostics()"}
    nnoremap {"<leader>gq", "vim.lsp.diagnostic.set_loclist()"}

    nnoremap {"<leader>gi", "require('lspsaga.provider').lsp_finder()"}
    -- nnoremap {"K", "require('lspsaga.hover').render_hover_doc()"}
    nnoremap {"K", "vim.lsp.buf.hover()"}
    nnoremap {"<leader>i", "require('lspsaga.signaturehelp').signature_help()"}
    nnoremap {"gp", "require'lspsaga.provider'.preview_definition()"}

    nnoremap {"<F2>", "require('lspsaga.rename').rename()"}
    nnoremap {"<leader>a", "require('lspsaga.codeaction').code_action()"}
    vnoremap {"<leader>a", "require('lspsaga.codeaction').range_code_action()"}

    nnoremap {"<leader>dd", "require'lspsaga.diagnostic'.show_line_diagnostics()"}
    nnoremap {"[d", "require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()"}
    nnoremap {"]d", "require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()"}
    -- mapper("n", "[d", "vim.lsp.diagnostic.goto_prev()")
    -- mapper("n", "]d", "vim.lsp.diagnostic.goto_next()")

    -- nnoremap {"<C-u>", "require('lspsaga.action').smart_scroll_with_saga(-1)"}
    -- nnoremap {"<C-d>", "require('lspsaga.action').smart_scroll_with_saga(1)"}
end

require("plugins.lsp.sources").setup(nvim_lsp, on_attach, capabilities)

return {
    on_attach = on_attach,
    capabilities = capabilities
}
