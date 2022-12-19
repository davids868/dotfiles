require("mason").setup()
require("mason-lspconfig").setup {
  automatic_installation = true,
}

-- require "config.lsp.tsserver"() -- also define the commands for lsp-utils so thy are available in telescope
local nvim_lsp = require "lspconfig"

vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format {
    -- filter = function(clients)
    --   return vim.tbl_filter(function(client)
    --     return client.name ~= "tsserver"
    --   end, clients)
    -- end,
    bufnr = bufnr,
  }
end

local on_attach = function(client, bufnr)
  require("sqls").on_attach(client, bufnr)

  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end

  if client.server_capabilities.documentHighlightProvider then
    require("config.lsp.highlight").setup()
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Mappings.
  vim.keymap.set("n", "gr", vim.lsp.buf.references)
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
  vim.keymap.set("n", "<leader>gv", function()
    vim.cmd "vsp"
    vim.lsp.buf.definition()
  end)
  vim.keymap.set("n", "<leader>gx", function()
    vim.cmd "sp"
    vim.lsp.buf.definition()
  end)
  vim.keymap.set("n", "<leader>gt", function()
    vim.cmd "tab split"
    vim.lsp.buf.definition()
  end)

  vim.keymap.set("n", "K", vim.lsp.buf.hover)

  vim.keymap.set("n", "<leader>rn", ":Lspsaga rename<CR>", { silent = true })
  vim.keymap.set("n", "<leader>a", ":Lspsaga code_action<CR>")
  vim.keymap.set("v", "<leader>a", ":Lspsaga range_code_action<CR>")

  vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

  vim.keymap.set("n", "<leader>ia", ":TSLspImportAll<CR>")
end

require("config.lsp.sources").setup(nvim_lsp, on_attach, capabilities)
require("config.lsp.null-ls").setup(on_attach)

vim.notify = function(msg, log_level, _)
  if msg:match "exit code" then
    return
  end
  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({ { msg } }, true, {})
  end
end

return {
  on_attach = on_attach,
  capabilities = capabilities,
}
