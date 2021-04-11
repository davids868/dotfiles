local setup = function(nvim_lsp, on_attach)
    nvim_lsp.vimls.setup {on_attach = on_attach}
    nvim_lsp.tsserver.setup {on_attach = on_attach}
    nvim_lsp.solargraph.setup {on_attach = on_attach}

    nvim_lsp.pyright.setup {
        on_attach = on_attach,
        settings = {
            python = {
                pythonPath = vim.env.VIRTUAL_PYTHON_PATH,
                venvPath = "/Users/david.sapiro/Library/Caches/pypoetry/virtualenvs/",
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true
                }
            }
        }
    }

    local sumneko_root_path = "/Users/david.sapiro/personal/lua-language-server"
    local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
    nvim_lsp.sumneko_lua.setup {
        on_attach = on_attach,
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT"
                    -- path = vim.split(package.path, ";")
                },
                diagnostics = {
                    globals = {"vim"}
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        [vim.fn.expand("/Users/david.sapiro/.config/nvim")] = true
                    }
                }
            }
        }
    }
end

return {setup = setup}
