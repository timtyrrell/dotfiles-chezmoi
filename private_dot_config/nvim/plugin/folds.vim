" folds
" toggle folds
nnoremap <space><space> za
vnoremap <space><space> za
" zf#j creates a fold from the cursor down # lines.
" zf/ string creates a fold from the cursor to string .
" zj moves the cursor to the next fold.
" zk moves the cursor to the previous fold.
" za toggle a fold at the cursor.
" zo opens a fold at the cursor.
" zO opens all folds at the cursor.
" zc closes a fold under cursor.
" zm increases the foldlevel by one.
" zM closes all open folds.
" zr decreases the foldlevel by one.
" zR decreases the foldlevel to zero -- all folds will be open.
" zd deletes the fold at the cursor.
" zE deletes all folds.
" [z move to start of open fold.
" ]z move to end of open fold.
" treesitter
set fillchars+=fold:\    " space
" Open files without any folding
set foldlevelstart=99

" Plug 'Konfekt/FastFold'
let g:fastfold_savehook = 1

lua << EOF

-- fold settings
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
-- vim.wo.fillchars = "fold:\\"
-- vim.wo.fillchars = "fold: "
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1

-- Open sub-folds at current code block level
local function open_sub_folds()
  local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
  local fold_closed = vim.fn.foldclosed(line_data[1])
  if fold_closed == -1 then -- not folded
    return  "zczO"
  else -- if fold - then open normall
    return "zO"
  end
end
vim.keymap.set( "n", "zO", open_sub_folds, { remap = false, expr = true } )

EOF
