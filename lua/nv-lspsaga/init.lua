local saga = require 'lspsaga'

saga.init_lsp_saga({
  code_action_keys = {
    quit = '<Escape>',exec = '<CR>'
  },
  rename_action_keys = {
    quit = '<Escape>',exec = '<CR>'  -- quit can be a table
  },
  use_saga_diagnostic_sign = false,
  code_action_prompt = {
    enable = false,
    sign = false,
    sign_priority = 20,
    virtual_text = false,
 },
 debug = true
})
