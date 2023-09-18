" switch back and forth with two most recent files in buffer
" nnoremap <Backspace> <C-^>

" go back to last old buffer
" nnoremap <silent> <bs> <c-o><cr>
" go forward to next newest buffer
" nnoremap <silent> <tab> <c-i<cr>

" nnoremap <Leader><Tab>  :buffer<Space><Tab>
nnoremap <silent> <c-n> :bnext<CR>
nnoremap <silent> <c-p> :bprev<CR>
" nnoremap <silent> <c-x> :bdelete<CR>

" vim tab navigation
" Next tab: gt
" Prior tab: gT
" Numbered tab: 7gt
"https://github.com/AndrewRadev/undoquit.vim#working-with-tabs
nnoremap <leader>tc  :UndoableTabclose<cr>
" nnoremap <leader>tc  :tabclose<cr>
nnoremap <leader>tn  :tabnew<cr>
" open buffer in new tab preserving cursor, preserving old buffer
nnoremap <leader>ts  :tab sp<cr>
nnoremap <leader>to  :tabonly<cr>
nnoremap <leader>tmh :-tabmove<CR>
nnoremap <leader>tml :+tabmove<CR>
nnoremap <leader>1   1gt
nnoremap <leader>2   2gt
nnoremap <leader>3   3gt
nnoremap <leader>4   4gt
nnoremap <leader>5   5gt
nnoremap <leader>6   6gt
nnoremap <leader>7   7gt
nnoremap <leader>8   8gt
nnoremap <leader>9   9gt
nnoremap <leader>0   :tablast<CR>
" open current file in new tab
" :help CTRL-W_T

" Let 'tl' toggle between this and the last accessed tab
" let g:lasttab = 1
" nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
" au TabLeave * let g:lasttab = tabpagenr()

" Plug 'kazhala/close-buffers.nvim'
map <leader>bdo :BDelete other<CR>
map <leader>bdh :BDelete hidden<CR>
map <leader>bda :BDelete all<CR>
map <leader>bdt :BDelete this<CR>
map <leader>bdn :BDelete nameless<CR>

" Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
nmap <Leader>mt :MundoToggle<CR>
let g:mundo_right=1

lua << EOF

require('fundo').setup()
require('highlight-undo').setup({
  -- duration = 300,
  -- undo = {
  --   hlgroup = 'HighlightUndo',
  --   mode = 'n',
  --   lhs = 'u',
  --   map = 'undo',
  --   opts = {}
  -- },
  -- redo = {
  --   hlgroup = 'HighlightUndo',
  --   mode = 'n',
  --   lhs = '<C-r>',
  --   map = 'redo',
  --   opts = {}
  -- },
  -- highlight_for_count = true,
})

EOF
