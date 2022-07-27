local lspconfig = require"lspconfig"
local prettier = require"efm/prettier"
-- local eslint = require"efm/eslint"

local custom_attach = function(client)
  print("'" .. client.name .. "' language server started" );
  client.resolved_capabilities.document_formatting = true
  -- key bindings ommitted
end

local languages = {
  -- typescript = {prettier,eslint},
  -- javascript = {prettier,eslint},
  -- typescriptreact = {prettier,eslint},
  -- javascriptreact = {prettier,eslint},
  scss = {prettier},
  css = {prettier},
  markdown = {prettier},
}

lspconfig.efm.setup {
  root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git"),
  filetypes = vim.tbl_keys(languages),
  init_options = {documentFormatting = false, codeAction = false},
  settings = {languages = languages, log_level = 1, log_file = '~/efm.log'},
  on_attach = custom_attach
}
