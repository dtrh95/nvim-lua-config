local cmd = vim.cmd
local opt = vim.opt

cmd "filetype plugin indent on"

cmd [[colorscheme gruvbox]]
opt.termguicolors = true
opt.shortmess:append "c"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = "utf-8"
opt.ttyfast = true
opt.mouse = "a"
opt.spelllang = "en"
opt.spellfile = "$HOME/spell/en.utf-8.add"
opt.cursorline = true
opt.updatetime = 100
opt.nrformats = "alpha,octal,hex"

opt.backspace = "indent,eol,start"
opt.completeopt = "menu,menuone,noinsert,noselect"

opt.tabstop = 2
opt.softtabstop = 0
opt.shiftwidth = 2
opt.expandtab = true

opt.hidden = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.wildmode = "list:longest,list:full"
opt.wildignore:append "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,yarn.lock,package-lock.json"
vim.api.nvim_exec(
  [[
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
]],
  true
)

opt.fileformats = "unix,dos,mac"

vim.g.session_directory = "~/.vim/session"
vim.g.session_autosave = "no"
vim.g.session_autoload = "no"
vim.g.session_command_aliases = 1

vim.wo.wrap = false
opt.ruler = true
opt.number = true
opt.relativenumber = true

vim.no_buffers_menu = 1
opt.gcr = "a:blinkon0"
opt.scrolloff = 5

opt.laststatus = 2

opt.title = true
opt.titleold = "Terminal"
opt.titlestring = "%F"
opt.clipboard = "unnamedplus"
opt.signcolumn = "yes"

opt.undofile = true
opt.undodir = "/Users/buddhistcoder/.vimundo/"

-- vim.api.nvim_exec([[
-- set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
-- ]], true)

vim.api.nvim_exec([[
filetype plugin indent on
set tags+=tags;$HOME
]], true)

vim.api.nvim_exec(
  [[
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>
]],
  true
)

vim.api.nvim_exec([[
  function! RipgrepFzf(query, fullscreen)
    let command_fmt = "rg --files --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*}'"
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction
  command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
]], true)

vim.fn.sign_define("LspDiagnosticsSignError", {text = "✘", texthl = "GruvboxRed"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", texthl = "GruvboxYellow"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", texthl = "GruvboxBlue"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", texthl = "GruvboxAqua"})

-- gitgutter
-- vim.g.gitgutter_sign_added = '|'
-- vim.g.gitgutter_sign_modified = '|'
-- vim.g.gitgutter_sign_remove = '|'
--

vim.cmd 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()'

vim.cmd(
  [[
set iskeyword-=.

let g:dbs = {
\  'dev': 'postgres://buddhistcoder:123123123@localhost:5433/aus_uat',
\  'prod': 'postgres://postgres:%40us2021Educ%40tion@103.232.55.46:5432/aus_uat'
\ }

let g:db_ui_table_helpers = {
\   'postgresql': {
\     'Count': 'select count(*) from "{table}"',
\     'List': 'select * from "{table}"'
\   }
\ }

nnoremap <silent>`3 :DBUIToggle<CR>

noremap zz <c-w>_ \| <c-w>\|
noremap zo <c-w>=

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "http", "json" },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

"" vim rest console
set ft=rest
let g:vrc_response_default_content_type = 'application/json'
let g:vrc_auto_format_response_patterns = {
      \ 'json': 'python -m json.tool',
      \ 'xml': 'xmllint --format -',
    \}

let g:vrc_trigger = '<space>r'

let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'tsx',
\  },
\}
let g:user_emmet_leader_key='<space>'
let g:user_emmet_mode='nv'

" blamer
let g:blamer_enabled = 1
let g:blamer_delay = 3000

command! -buffer JdtCompile lua require('jdtls').compile()
command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
command! -buffer JdtJol lua require('jdtls').jol()
command! -buffer JdtBytecode lua require('jdtls').javap()
command! -buffer JdtJshell lua require('jdtls').jshell()

highlight DiagnosticUnderlineInfo gui=undercurl term=undercurl
highlight DiagnosticUnderlineWarn gui=undercurl term=undercurl
highlight DiagnosticUnderlineError gui=undercurl term=undercurl
highlight DiagnosticUnderlineHint gui=undercurl term=undercurl
highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine
highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine
highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine
highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine
highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine
highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine
highlight! IndentBlanklineContextChar guifg=#D65D0E gui=nocombine
highlight! IndentBlanklineContextStart guisp=#D65D0E gui=underline
]]
)
