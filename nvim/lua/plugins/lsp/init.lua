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

    nnoremap {"gr", "<cmd>lua vim.lsp.buf.references()<CR>"}
    nnoremap {"<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>"}
    nnoremap {"<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>"}
    nnoremap {"<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>"}
    -- nnoremap {"<leader>i", "vim.lsp.diagnostic.show_line_diagnostics()<CR>"}
    nnoremap {"<leader>gq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>"}

    nnoremap {"<leader>gi", "<cmd>lua require('lspsaga.provider').lsp_finder()<CR>"}
    nnoremap {"K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>"}
    -- nnoremap {"K", "vim.lsp.buf.hover()"}
    nnoremap {"<leader>i", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>"}
    nnoremap {"gp", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>"}

    nnoremap {"<leader>rN", "<cmd>lua require('lspsaga.rename').rename()<CR>"}
    nnoremap {"<leader>a", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>"}
    vnoremap {"<leader>a", "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>"}

    nnoremap {"<leader>dd", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>"}
    nnoremap {"[d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>"}
    nnoremap {"]d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>"}
    -- nnoremap {"<C-u>", "require('lspsaga.action').smart_scroll_with_saga(-1)"}
    -- nnoremap {"<C-d>", "require('lspsaga.action').smart_scroll_with_saga(1)"}
end

require("plugins.lsp.sources").setup(nvim_lsp, on_attach, capabilities)

return {
    on_attach = on_attach,
    capabilities = capabilities
}
