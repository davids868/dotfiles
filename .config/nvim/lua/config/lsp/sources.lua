-- local root_pattern = require("nvim_lsp/util").root_pattern
-- local root_pattern = require "lspconfig/util".root_pattern
-- local setup_diagls = function(nvim_lsp, on_attach)
--     local filetypes = {
--         javacript = "eslint",
--         javascriptreact = "eslint",
--         typescript = "eslint",
--         typescriptreact = "eslint"
--     }

--     local linters = {
--         eslint = {
--             sourceName = "eslint",
--             command = "eslint_d",
--             rootPatterns = {".eslintrc.js", "package.json", ".eslintrc", "translations/.eslintrc"},
--             debounce = 100,
--             args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
--             parseJson = {
--                 errorsRoot = "[0].messages",
--                 line = "line",
--                 column = "column",
--                 endLine = "endLine",
--                 endColumn = "endColumn",
--                 message = "${message} [${ruleId}]",
--                 security = "severity"
--             },
--             securities = {[2] = "error", [1] = "warning"}
--         }
--     }

--     local formatters = {
--         prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
--     }

--     local formatFiletypes = {
--         typescript = "prettier",
--         typescriptreact = "prettier"
--     }

--     nvim_lsp.diagnosticls.setup {
--         on_attach = on_attach, capabilities = capabilities,
--         filetypes = vim.tbl_keys(filetypes),
--         init_options = {
--             filetypes = filetypes,
--             linters = linters,
--             formatters = formatters,
--             formatFiletypes = formatFiletypes
--         }
--     }
-- end

local configs = require "lspconfig/configs"
local util = require "lspconfig/util"

local server_name = "graphql"
local bin_name = "graphql-lsp"

configs[server_name] = {
  default_config = {
    cmd = { bin_name, "server", "-m", "stream" },
    filetypes = { "graphql" },
    root_dir = util.root_pattern(".git", ".graphqlrc"),
  },
  docs = {
    default_config = {
      root_dir = [[root_pattern('.git', '.graphqlrc')]],
    },
  },
}

local setup = function(nvim_lsp, on_attach, capabilities)
  -- nvim_lsp.efm.setup {on_attach = on_attach, capabilities = capabilities}
  require("typescript").setup {
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
      fallback = true,
    },
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = function(pattern)
        local root = util.root_pattern("package.json", "tsconfig.json", ".git")(pattern)
        return root or vim.loop.cwd()
      end,
    },
  }
  -- nvim_lsp.denols.setup {}
  nvim_lsp.vimls.setup { on_attach = on_attach, capabilities = capabilities }
  nvim_lsp.solargraph.setup { on_attach = on_attach, capabilities = capabilities }
  -- nvim_lsp.sorbet.setup {on_attach = on_attach, capabilities = capabilities}
  nvim_lsp.jsonls.setup { on_attach = on_attach, capabilities = capabilities }
  -- nvim_lsp.graphql.setup {on_attach = on_attach, capabilities = capabilities}
  -- nvim_lsp.gopls.setup { on_attach = on_attach, capabilities = capabilities }
  nvim_lsp.terraformls.setup { on_attach = on_attach, capabilities = capabilities }
  -- nvim_lsp.clangd.setup { on_attach = on_attach, capabilities = capabilities }
  nvim_lsp.ccls.setup { on_attach = on_attach, capabilities = capabilities }
  -- nvim_lsp.rnix.setup { on_attach = on_attach, capabilities = capabilities }
  nvim_lsp.tailwindcss.setup { on_attach = on_attach, capabilities = capabilities }
  nvim_lsp.prismals.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = util.root_pattern(".git", "package.json", "pyproject.toml"),
  }
  -- nvim_lsp.sqlls.setup {
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --   root_dir = util.find_git_ancestor,
  -- }
  -- nvim_lsp.sqls.setup {
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --   settings = {
  --     sqls = {
  --       connections = {
  --         {
  --           driver = "postgresql",
  --           dataSourceName = "host=10.145.192.5 port=5432 user=postgres password='$Cord$$$1.00' dbname=postgres sslmode=disable",
  --         },
  --       },
  --     },
  --   },
  -- }

  -- nvim_lsp.typeprof.setup { on_attach = on_attach, capabilities = capabilities }

  -- setup_diagls(nvim_lsp, on_attach)

  nvim_lsp.stylelint_lsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    -- root_dir = util.root_pattern(".stylelintrc", ".stylelintrc.json", "package.json")
  }

  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- nvim_lsp.html.setup {
  --     capabilities = capabilities,
  --     on_attach = on_attach
  -- }

  nvim_lsp.cssls.setup {
    cmd = { "css-languageserver", "--stdio" },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      scss = {
        validate = false,
      },
    },
  }

  local pyright_settings = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      python = {
        venvPath = "/home/davids/.cache/pypoetry/virtualenvs/",
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  }

  local venv = vim.env.VENV_PATH

  if venv then
    pyright_settings.settings.python.pythonPath = venv .. "/bin/python"
    pyright_settings.settings.python.analysis.extraPaths = { vim.env.VENV_PATH .. "lib" }
  end

  nvim_lsp.pyright.setup { pyright_settings }

  nvim_lsp.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          -- path = vim.split(package.path, ";")
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            [vim.fn.expand "/Users/david.sapiro/.config/nvim"] = true,
          },
        },
      },
    },
  }

  nvim_lsp.yamlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      yaml = {
        schemas = {
          ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci",
          ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose",
        },
      },
    },
  }
end

return { setup = setup }
