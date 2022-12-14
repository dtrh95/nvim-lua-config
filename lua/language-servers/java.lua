local M = {}
function M.setup()
  local on_attach = function(_, bufnr)
    require "jdtls.setup".add_commands()

    vim.api.nvim_exec(
      [[
        augroup FormatAutogroup
          autocmd!
          autocmd BufWritePost *.java FormatWrite
        augroup end
      ]],
      true
    )

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>2", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", '<cmd>lua vim.lsp.buf.references() && vim.cmd("copen")<CR>', opts)
    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "[c", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]c", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    -- Java specific
    buf_set_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    buf_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
    buf_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
    buf_set_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    buf_set_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
    buf_set_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

    buf_set_keymap("n", "<leader>pf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    vim.api.nvim_exec(
      [[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
          augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
      ]],
      false
    )
  end
  vim.cmd [[set softtabstop=4]]
  vim.cmd [[set shiftwidth=4]]
  vim.cmd [[set noexpandtab]]

  vim.cmd [[command! -buffer JdtCompile lua require('jdtls').compile()]]
  vim.cmd [[command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()]]
  vim.cmd [[command! -buffer JdtJol lua require('jdtls').jol()]]
  vim.cmd [[command! -buffer JdtBytecode lua require('jdtls').javap()]]
  vim.cmd [[command! -buffer JdtJshell lua require('jdtls').jshell()]]

  local root_markers = {"gradlew", "pom.xml"}
  local root_dir = require("jdtls.setup").find_root(root_markers)
  local home = os.getenv("HOME")

  local capabilities = {
    workspace = {
      configuration = true
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  }

  local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local config = {
    flags = {
      allow_incremental_sync = true
    },
    capabilities = capabilities,
    on_attach = on_attach
  }

  config.cmd = {"java-lsp.sh", workspace_folder}
  config.on_attach = on_attach
  config.on_init = function(client, _)
    client.notify("workspace/didChangeConfiguration", {settings = config.settings})
  end

  local extendedClientCapabilities = require "jdtls".extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  config.init_options = {
    -- bundles = bundles;
    extendedClientCapabilities = extendedClientCapabilities
  }

  require("jdtls").start_or_attach(config)
end

return M
