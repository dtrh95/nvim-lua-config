local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

return require("packer").startup(
  function(use)
    use "wbthomason/packer.nvim"

    -- Core
    use {"neovim/nvim-lspconfig"}
    use "glepnir/dashboard-nvim"

    use "triglav/vim-visual-increment"
    use "tpope/vim-dotenv"

    use {"mhartington/formatter.nvim"}
    use {"windwp/nvim-ts-autotag"}
    use {"JoosepAlviste/nvim-ts-context-commentstring"}

    use {"williamboman/nvim-lsp-installer"}

    use {"nvim-treesitter/nvim-treesitter"}

    use "kyazdani42/nvim-tree.lua"
    use "kyazdani42/nvim-web-devicons"

    -- AutoComplete
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        {
          'quangnguyen30192/cmp-nvim-tags',
          -- if you want the sources is available for some file types
          ft = {
            'kotlin',
            'java',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact'
          }
        }
      },
    }
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/cmp-vsnip"

    -- Colors
    use "dtrh95/gruvbox"
    use 'folke/lsp-colors.nvim'
    use "lukas-reineke/indent-blankline.nvim"

    -- UI
    use {
      "hoob3rt/lualine.nvim",
      requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }
    use {"akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons"}

    use "windwp/nvim-autopairs"

    use "tpope/vim-commentary"
    use "tpope/vim-surround"

    use "nvim-lua/plenary.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    use "norcalli/nvim-colorizer.lua"

    use "airblade/vim-gitgutter"

    use "tpope/vim-fugitive"

    use "famiu/bufdelete.nvim"

    use {"akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim"}

    use "bkad/camelcasemotion"

    use {
      "ojroques/nvim-lspfuzzy",
      requires = {
        {"junegunn/fzf"},
        {"junegunn/fzf.vim"} -- to enable preview (optional)
      }
    }

    use "MaxMEllon/vim-jsx-pretty"

    use "mfussenegger/nvim-jdtls"
    use "mfussenegger/nvim-dap"

    use "tpope/vim-dadbod"
    use "kristijanhusak/vim-dadbod-ui"
    use "kristijanhusak/vim-dadbod-completion"

    use "diepm/vim-rest-console"

    use "mattn/emmet-vim"

    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    }

    use {"tpope/vim-eunuch"}

    use "APZelos/blamer.nvim"

    use "natecraddock/sessions.nvim"
    use "natecraddock/workspaces.nvim"

    use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })
  end
)
