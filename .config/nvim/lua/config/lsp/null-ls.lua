local null_ls = require "null-ls"

null_ls.setup {
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd [[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]]
    end
  end,
  sources = {
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.vale,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.buf,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.mix,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.rufo,
    null_ls.builtins.formatting.stylelint,
    null_ls.builtins.formatting.prettier.with {
      prefer_local = "node_modules/.bin",
    },
  },
}
