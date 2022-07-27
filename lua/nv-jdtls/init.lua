vim.api.nvim_exec([[
augroup lsp
  au!
  au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}})
augroup end

autocmd FileType java nnoremap <leader>c <Cmd>lua require('jdtls').code_action()<CR>
autocmd FileType java vnoremap <space>c <Esc><Cmd>lua require('jdtls').code_action(true)<CR>
autocmd FileType java nnoremap <leader>r <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>

autocmd FileType java nnoremap <leader>gi <Cmd>lua require'jdtls'.organize_imports()<CR>
autocmd FileType java nnoremap <leader>ev <Cmd>lua require('jdtls').extract_variable()<CR>
autocmd FileType java vnoremap <leader>evt <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
autocmd FileType java nnoremap <leader>ec <Cmd>lua require('jdtls').extract_constant()<CR>
autocmd FileType java vnoremap <leader>ect <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
autocmd FileType java vnoremap <leader>emt <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>

nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
]], true);

vim.cmd 'command! -buffer JdtCompile lua require("jdtls").compile()'
vim.cmd 'command! -buffer JdtUpdateConfig lua require("jdtls").update_project_config()'
vim.cmd 'command! -buffer JdtJol lua require("jdtls").jol()'
vim.cmd 'command! -buffer JdtBytecode lua require("jdtls").javap()'
vim.cmd 'command! -buffer JdtJshell lua require("jdtls").jshell()'

require('jdtls').setup_dap()
require('jdtls').start_or_attach({
  cmd = {'java-lsp.sh'},
  root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'}),
})
