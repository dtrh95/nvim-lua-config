require('formatter').setup({
  filetype = {
    javascript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--config', vim.fn.getcwd() .. '/.prettierrc'},
          stdin = true
        }
      end
    },

    typescript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--config', vim.fn.getcwd() .. '/.prettierrc'},
          stdin = true
        }
      end
    },

    typescriptreact = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--config', vim.fn.getcwd() .. '/.prettierrc'},
          stdin = true
        }
      end
    },

    scss = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--config', vim.fn.getcwd() .. '/.prettierrc'},
          stdin = true
        }
      end
    },

    lua = {
      -- luafmt
      function()
        return {
          exe = "luafmt",
          args = {"--indent-count", 2, "--stdin"},
          stdin = true
        }
      end
    }
  }
})
