local M = {}

M.setup = function(on_attach)
  local null_ls = require "null-ls"
  null_ls.setup {
    on_attach = on_attach,
    sources = {
      -- null_ls.builtins.code_actions.refactoring,
      -- null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.hover.dictionary,
      -- null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.diagnostics.vale,
      null_ls.builtins.diagnostics.buf,
      -- null_ls.builtins.diagnostics.codespell,
      -- null_ls.builtins.diagnostics.cspell,
      null_ls.builtins.diagnostics.credo,
      null_ls.builtins.diagnostics.rubocop,
      -- null_ls.builtins.diagnostics.stylelint,
      null_ls.builtins.diagnostics.vint,
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.buf,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.golines,
      null_ls.builtins.formatting.mix,
      -- null_ls.builtins.formatting.rubocop,
      -- null_ls.builtins.formatting.rufo,
      -- null_ls.builtins.formatting.standardrb,
      null_ls.builtins.formatting.stylelint,
      null_ls.builtins.formatting.prettier.with {
        prefer_local = "node_modules/.bin",
      },
      null_ls.builtins.formatting.nixfmt,
    },
  }
end

return M
