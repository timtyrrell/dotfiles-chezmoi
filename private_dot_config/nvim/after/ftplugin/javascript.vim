:inoreabbrev <buffer> cl console.log("");<esc>F"

" nnoremap <leader>tf :call CocActionAsync('runCommand', 'jest.fileTest', ['%'])<CR>
" nnoremap <leader>tt :call CocActionAsync('runCommand', 'jest.singleTest')<CR>
" nnoremap <leader>ts :call CocActionAsync('runCommand', 'jest.projectTest')<CR>

" augroup move_these_to_ftplugin
"   autocmd!
  " autocmd FileType javascript,typescript, nnoremap <buffer> <C-]> :TernDef<CR>
  " autocmd BufWritePost *.jsx,*.js CocCommand eslint.executeAutofix
" augroup END

lua << EOF
-- David-Kunz/jester
vim.api.nvim_set_keymap('n', '<leader>td', ':lua require"jester".debug({ cmd = "yarn jest" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>t_', ':lua require"jester".run_last({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>tt', ':lua require"jester".run({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>t_', ':lua require"jester".run_last({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>tf', ':lua require"jester".run_file({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>d_', ':lua require"jester".debug_last({ path_to_jest = "node_modules/.bin/jest" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>df', ':lua require"jester".debug_file({ path_to_jest = "node_modules/.bin/jest" })<cr>', {})
EOF
