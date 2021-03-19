vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
    -- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}
    -- buf_set_keymap("n", "<leader>gd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "<leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    -- buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts)
    -- buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    -- buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    -- buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

    if client.resolved_capabilities.document_highlight then
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
end

local util = require "lspconfig/util"
nvim_lsp.solargraph.setup {on_attach = on_attach}
nvim_lsp.pyright.setup {
    on_attach = on_attach,
    -- cmd = {"poetry", "run pyright-langserver --stdio"},
    settings = {
        python = {
            -- pythonPath = "/Users/david.sapiro/Library/Caches/pypoetry/virtualenvs/document-orchestrator-v2_8hdZA-py3.7/bin/python",
            venvPath = "/Users/david.sapiro/Library/Caches/pypoetry/virtualenvs/",
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true
            }
        }
    }
}
nvim_lsp.vimls.setup {on_attach = on_attach}
-- nvim_lsp.jedi_language_server.setup {on_attach = on_attach}
-- nvim_lsp.pyls.setup {
--     on_attach = on_attach,
--     enable = true,
--     plugins = {
--         pyls_mypy = {
--             enabled = true
--         }
--     }
-- }

local sumneko_root_path = "/Users/david.sapiro/personal/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";")
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {"vim"}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                }
            }
        }
    }
}
