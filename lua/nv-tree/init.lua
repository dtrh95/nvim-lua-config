local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local list = {
      { key = {"l", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
      { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
      { key = "<C-v>",                        cb = tree_cb("vsplit") },
      { key = "<C-x>",                        cb = tree_cb("split") },
      { key = "<C-t>",                        cb = tree_cb("tabnew") },
      { key = "<",                            cb = tree_cb("prev_sibling") },
      { key = ">",                            cb = tree_cb("next_sibling") },
      { key = "P",                            cb = tree_cb("parent_node") },
      { key = "h",                            cb = tree_cb("close_node") },
      { key = "<S-CR>",                       cb = tree_cb("close_node") },
      { key = "<Tab>",                        cb = tree_cb("preview") },
      { key = "K",                            cb = tree_cb("first_sibling") },
      { key = "J",                            cb = tree_cb("last_sibling") },
      { key = "I",                            cb = tree_cb("toggle_ignored") },
      { key = ".",                            cb = tree_cb("toggle_dotfiles") },
      { key = "R",                            cb = tree_cb("refresh") },
      { key = "a",                            cb = tree_cb("create") },
      { key = "d",                            cb = tree_cb("remove") },
      { key = "r",                            cb = tree_cb("rename") },
      { key = "<C-r>",                        cb = tree_cb("full_rename") },
      { key = "x",                            cb = tree_cb("cut") },
      { key = "c",                            cb = tree_cb("copy") },
      { key = "p",                            cb = tree_cb("paste") },
      { key = "y",                            cb = tree_cb("copy_name") },
      { key = "Y",                            cb = tree_cb("copy_path") },
      { key = "gy",                           cb = tree_cb("copy_absolute_path") },
      { key = "[g",                           cb = tree_cb("prev_git_item") },
      { key = "]g",                           cb = tree_cb("next_git_item") },
      { key = "<BS>",                         cb = tree_cb("dir_up") },
      { key = "q",                            cb = tree_cb("close") },
      { key = "g?",                           cb = tree_cb("toggle_help") },
    }

require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = true,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "???",
      info = "???",
      warning = "???",
      error = "???",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = true,
    ignore_list = {}
  },
  system_open = {
    cmd  = "",
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = { '.git' }
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = list
    }
  }
}


local M = {}

local function file_exists(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

M.config = function()
  require('nvim-tree.events').on_file_created(function(ev)
    local fname = ev.fname
    -- makes relevant files executables
    if
      (fname:match '/%.local/bin/' or fname:match '^%.local/bin/')
      and not fname:match '%.local/bin/.+%.'
    then
      os.execute(string.format('chmod +x %q', fname))
    end
    -- when new file belongs to an active stow package, stow it
    local dots = os.getenv 'DOTFILES'
    if vim.fn.getcwd() == dots then
      local stow_package = fname:match('^(.-)/', #dots + 2)
      if
        file_exists(
          string.format(
            '%s/.config/stow/active/%s',
            os.getenv 'HOME',
            stow_package
          )
        )
      then
        os.execute(string.format('stow %q', stow_package))
      end
    end
    vim.cmd(string.format('e %s', fname))
    require('modules.templates').template_match()
  end)
end

return M

