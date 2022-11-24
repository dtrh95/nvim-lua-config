local lspconfig = require "lspconfig"
local ts_utils = require("nvim-lsp-ts-utils")

local custom_attach = function(client, bufnr)
  -- print("'" .. client.name .. "' language server started" );
  client.resolved_capabilities.document_formatting = false

  vim.cmd("command! -buffer Formatting lua vim.lsp.buf.formatting()")

  -- format on save
  -- vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")

  -- defaults
  ts_utils.setup {
    debug = true,
    disable_commands = false,
    enable_import_on_completion = true,
    -- import all
    import_all_timeout = 5000, -- ms
    import_all_priorities = {
      buffers = 4, -- loaded buffer names
      buffer_content = 3, -- loaded buffer content
      local_files = 2, -- git files or files with relative path markers
      same_file = 1 -- add to existing import statement
    },
    import_all_scan_buffers = 100,
    import_all_select_source = false,
    -- eslint
    -- eslint_enable_code_actions = true,
    -- eslint_enable_disable_comments = true,
    -- eslint_bin = "eslint_d",
    -- eslint_config_fallback = nil,
    -- eslint_enable_diagnostics = true,

    -- formatting
    -- enable_formatting = false,
    -- formatter = "prettier",
    -- formatter_config_fallback = nil,

    -- update imports on file move
    require_confirmation_on_move = true,
    update_imports_on_move = true,
    watch_dir = nil
  }

  -- required to fix code action ranges
  ts_utils.setup_client(client) -- key bindings ommitted

  local opts = {silent = true}

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", ":TSLspRenameFile<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
end

local null_ls = require("null-ls")

null_ls.setup(
  {
    sources = {
      null_ls.builtins.diagnostics.eslint_d, -- eslint or eslint_d
      null_ls.builtins.code_actions.eslint_d, -- eslint or eslint_d
      null_ls.builtins.formatting.eslint_d, -- prettier, eslint, eslint_d, or prettierd
      null_ls.builtins.code_actions.refactoring
    }
  }
)

vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
  {"🭽", "FloatBorder"},
  {"▔", "FloatBorder"},
  {"🭾", "FloatBorder"},
  {"▕", "FloatBorder"},
  {"🭿", "FloatBorder"},
  {"▁", "FloatBorder"},
  {"🭼", "FloatBorder"},
  {"▏", "FloatBorder"}
}

-- LSP settings (for overriding per client)
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.tsserver.setup(
  {
    capabilities = capabilities,
    init_options = require("nvim-lsp-ts-utils").init_options,
    cmd = {"/Users/buddhistcoder/Workspace/typescript-language-server/server/lib/cli.js", "--stdio"},
    on_attach = custom_attach,
    handlers = handlers
    -- settings = {documentFormatting = false},
  }
)

local cwd = vim.fn.getcwd()
local project_library_path = cwd .. "/node_modules"

local cmd = {
    project_library_path .. "/@angular/language-server/bin/ngserver",
    "--ngProbeLocations",
    project_library_path,
    "--tsProbeLocations",
    project_library_path ,
    "--stdio",
}

lspconfig.angularls.setup{
  capabilities = capabilities,
  init_options = require("nvim-lsp-ts-utils").init_options,
  cmd = cmd,
  filetypes = {
    'html'
  },
  on_new_config = function(new_config, new_root_dir)
      new_config.cmd = cmd
  end,
  on_attach = custom_attach,
  handlers = handlers
}

vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)"
}
