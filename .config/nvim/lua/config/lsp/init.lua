require("mason").setup()
require("mason-lspconfig").setup {
  automatic_installation = true,
}

-- require "config.lsp.tsserver"() -- also define the commands for lsp-utils so thy are available in telescope
local nvim_lsp = require "lspconfig"

vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

local nnoremap = require("utils.mappers").nnoremap
local vnoremap = require("utils.mappers").vnoremap

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
  nnoremap { "gr", "<cmd>lua vim.lsp.buf.references()<CR>" }
  nnoremap { "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>" }
  nnoremap { "<leader>gv", ":vsp<cr> <cmd>lua vim.lsp.buf.definition()<CR>" }
  nnoremap { "<leader>gx", ":sp<cr> <cmd>lua vim.lsp.buf.definition()<CR>" }
  nnoremap { "<leader>gt", ":tab split<cr><cmd>lua vim.lsp.buf.definition()<CR>" }

  nnoremap { "K", "<cmd>lua vim.lsp.buf.hover()<CR>" }
  -- nnoremap {"K", "vim.lsp.buf.hover()"}
  nnoremap { "<leader>i", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>" }
  nnoremap { "gp", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>" }

  nnoremap { "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true } }
  nnoremap { "<leader>a", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>" }
  vnoremap { "<leader>a", "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>" }

  nnoremap { "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>" }
  nnoremap { "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>" }
  nnoremap { "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>" }

  nnoremap { "<leader>ia", "<cmd>TSLspImportAll<CR>" }
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
