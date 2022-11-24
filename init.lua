-- language servers loading
require "language-servers/tsserver"
require "language-servers/lua-language-server"
require "language-servers/flutter"
require "language-servers/cssls"
local java_lsp = require "language-servers/java"
-- java_lsp.setup()

require "plugins"
require "keymappings"
require "settings"
require "nv-formatter"
-- require "nv-indentline"
require "nv-bufferline"
require "nv-lualine"
require "nv-colorized"
require "nv-tree"
require "nv-refactor"
require "nv-treesitter"
require "nv-indent-blankline"
require "nv-session"
require "nv-workspace"
require "neo-test"

-- require "nv-jdtls"
require "nv-cmp"

-- load plugin
require("nvim-autopairs").setup()
require("lsp-colors").setup()

-- ts autotag
require("nvim-ts-autotag").setup()
