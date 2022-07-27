local custom_attach = function(client)
  print("'" .. client.name .. "' language server started" );
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require"lspconfig";
lspconfig.cssls.setup({
  on_attach = custom_attach,
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_dir = lspconfig.util.root_pattern("package.json"),
  settings = {
    css = {
      validate = true
    },
    less = {
      validate = true
    },
    scss = {
      validate = true
    }
  },
  capabilities = capabilities
})
