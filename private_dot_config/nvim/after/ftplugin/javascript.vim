:inoreabbrev <buffer> cl console.log("");<esc>F"

nnoremap <leader>tf :call CocActionAsync('runCommand', 'jest.fileTest', ['%'])<CR>
nnoremap <leader>tt :call CocActionAsync('runCommand', 'jest.singleTest')<CR>
nnoremap <leader>ts :call CocActionAsync('runCommand', 'jest.projectTest')<CR>
