local custom_attach = function(client)
  print("'" .. client.name .. "' language server started" );

  -- key bindings ommitted
end

local dart_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
dart_capabilities.textDocument.codeAction = {
  dynamicRegistration = false;
  codeActionLiteralSupport = {
    codeActionKind = {
        valueSet = {
           "",
           "quickfix",
           "refactor",
           "refactor.extract",
           "refactor.inline",
           "refactor.rewrite",
           "source",
           "source.organizeImports",
        };
    };
  };
}

require"lspconfig".dartls.setup({
  on_attach = custom_attach,
  cmd = { "dart", "/usr/local/opt/dart/libexec/bin/snapshots/analysis_server.dart.snapshot", "--lsp" },
  filetypes = { "dart" },
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = true,
    suggestFromUnimportedLibraries = false,
    closingLabels = true,
  };
  capabilities = dart_capabilities,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = function(bufnr, _)
      local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
      -- No buffer local variable set, so just enable by default
      if not ok then
        return true
      end

      return result
    end,
    -- Disable a feature
    update_in_insert = false,
  }
)
require("flutter-tools").setup {}
