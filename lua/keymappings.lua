local opts = {noremap = true, silent = true}
vim.g.mapleader = ","
vim.api.nvim_set_keymap("n", "n", "nzzzv", opts)
vim.api.nvim_set_keymap("n", "N", "Nzzzv", opts)

-- Split
vim.api.nvim_set_keymap("n", "<leader>h", ":<C-u>split<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>v", ":<C-u>vsplit<CR>", opts)

-- Buffer nav
vim.api.nvim_set_keymap("n", "<leader>q", ":BufferLineCyclePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>w", ":BufferLineCycleNext<CR>", opts)

-- Switchings window
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)

-- fast indent
vim.api.nvim_set_keymap("v", "<", "<gv", {silent = true})
vim.api.nvim_set_keymap("v", ">", ">gv", {silent = true})

-- moving visual line up and down
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv'", opts)
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv'", opts)
vim.api.nvim_set_keymap("n", "<leader>j", ":m .+1<CR>==", opts)
vim.api.nvim_set_keymap("n", "<leader>k", ":m .-2<CR>==", opts)

-- close buffer
vim.api.nvim_set_keymap("n", "<leader>bd", ":Bdelete!<CR>", opts)

-- ESC to clean highlight search
vim.api.nvim_set_keymap("n", "<leader><leader>", ":noh<CR>", opts)

-- Reload vimr configuration file
vim.api.nvim_set_keymap("n", "<leader>PL", ":source $MYVIMRC<CR>", opts)

-- resize window
vim.api.nvim_set_keymap("n", "<leader>+", ":vertical resize + 20<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>-", ":vertical resize - 20<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>=", ":BufferLineMoveNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>-", ":BufferLineMovePrev<CR>", opts)

-- C-n C-p to C-j C-k
vim.api.nvim_set_keymap("i", "<C-j>", "<C-n>", opts)
vim.api.nvim_set_keymap("i", "<C-k>", "<C-p>", opts)

-- nvim tree
vim.api.nvim_set_keymap("n", "``", ":NvimTreeToggle<CR>", opts)

-- ======================================= START KEYMAPPING LSP ====================================================
-- Mappings.

-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.api.nvim_set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
vim.api.nvim_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>wl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>D", ":lua vim.lsp.buf.type_definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>2", ":lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>k", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", ":lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>c", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
vim.api.nvim_set_keymap("n", "[g", ":GitGutterPrevHunk<CR>", opts)
vim.api.nvim_set_keymap("n", "]g", ":GitGutterNextHunk<CR>", opts)

-- vim.api.nvim_set_keymap("n", "<leader>pf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- ======================================= START KEYMAPPING LSP ====================================================

-- vim.api.nvim_command([[autocmd FileType javascriptreact, typescriptreact nnoremap <buffer> <leader>e mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F]])

-- format
vim.api.nvim_set_keymap("n", "<leader>pf", ":Format<CR>", opts)

vim.api.nvim_set_keymap("n", "[c", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]c", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- fzf

-- dart, css, scss format on save
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.dart,*.scss,*.css FormatWrite
augroup END
]],
  true
)

-- easymotion
vim.api.nvim_exec(
  [[
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge
]],
  true
)

-- gitgutter
vim.api.nvim_exec(
  [[
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'
]],
  true
)

-- fzf
vim.api.nvim_set_keymap("n", "<leader>f", ":Rg<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-p>", ":Files<cr>", opts)
vim.api.nvim_set_keymap("n", "<C-b>", ":Buffers<cr>", opts)

-- format json
vim.api.nvim_set_keymap("n", "<space>j", ":%!jq .<CR>", {noremap = true})

-- tags
vim.api.nvim_set_keymap("n", "<space>t", ":!ctags -R -f<CR>", {noremap = true})

-- git
-- vim.api.nvim_set_keymap('n', ']g', "<Plug>(GitGutterNextHunk)", {silent = true})
-- vim.api.nvim_set_keymap('n', '[g', "<Plug>(GitGutterPrevHunk)", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>gd", ":Gvdiffsplit", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>d", '"ayiwOconsole.log(\'<C-R>a:\', <C-R>a);<Esc>', {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>PL", ":source /Users/buddhistcoder/.vim/init.lua<CR>", {noremap = true})

--refactor
vim.api.nvim_set_keymap(
  "v",
  "<Leader>re",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
  {noremap = true, silent = true, expr = false}
)
vim.api.nvim_set_keymap(
  "v",
  "<Leader>rf",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
  {noremap = true, silent = true, expr = false}
)

vim.api.nvim_set_keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], {noremap = true, silent = true, expr = false})


vim.api.nvim_exec([[
  function NvimTreeChangeDirFunc()
    :lua require'nvim-tree'.change_dir(vim.fn.getcwd())
  endfunction

  :command -nargs=0 NvimTreeChangeDir :call NvimTreeChangeDirFunc()
]], true)

vim.api.nvim_exec([[
let g:dashboard_default_executive ='fzf'
nmap <Leader>ss :<C-u>SessionsSave .nvim/session<CR>
nmap <Leader>sl :<C-u>SessionsLoad .nvim/session<CR>

command! -nargs=+ Silent
\   execute 'silent <args>'
\ | redraw!

function SaveFileAndSessionFunc()
  :NvimTreeClose
  :w
  :SessionsSave .nvim/session
endfunction

:command -nargs=0 SaveFileAndSession :call SaveFileAndSessionFunc()
]], true)

vim.api.nvim_exec([[
function EslintAndSaveFunc()
  :lua vim.lsp.buf.formatting_sync()
  :SaveFileAndSession
endfunction

:command -nargs=0 EslintAndSave :call EslintAndSaveFunc()
autocmd FileType rest nnoremap <buffer> <leader>c :call VrcQuery()<CR>
autocmd FileType typescript,typescriptreact,javascript,javascriptreact nnoremap <buffer> <leader>c :lua vim.lsp.buf.code_action()<CR>

nnoremap <silent><space>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><space>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><space>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><space>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><space>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><space>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><space>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><space>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><space>9 <Cmd>BufferLineGoToBuffer 9<CR>
]], true)

vim.api.nvim_exec([[
autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
]], true)


-- eslint autofix
vim.api.nvim_set_keymap("n", "<leader>e", ":EslintAndSave<CR>", opts)
vim.api.nvim_set_keymap("n", "`1", ":NvimTreeFindFile<CR>", opts)
