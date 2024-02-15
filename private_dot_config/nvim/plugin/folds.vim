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

" set fillchars+=fold:\    " space

" toggle folds
nnoremap <space><space> za
vnoremap <space><space> za

lua << EOF

-- vim.wo.fillchars = "fold:\\"
-- vim.wo.fillchars = "fold: "
-- vim.wo.foldnestmax = 3
-- vim.wo.foldminlines = 1

-- -- Open sub-folds at current code block level
-- local function open_sub_folds()
--   local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
--   local fold_closed = vim.fn.foldclosed(line_data[1])
--   if fold_closed == -1 then -- not folded
--     return  "zczO"
--   else -- if fold - then open normall
--     return "zO"
--   end
-- end
-- vim.keymap.set( "n", "zO", open_sub_folds, { remap = false, expr = true } )

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99 -- open files without any folding
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff:╱]]

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
 vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
 vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

 local handler = function(virtText, lnum, endLnum, width, truncate)
     local newVirtText = {}
     local suffix = (' 󱦶 %d '):format(endLnum - lnum)
     -- local suffix = ('  %d '):format(endLnum - lnum)
     local sufWidth = vim.fn.strdisplaywidth(suffix)
     local targetWidth = width - sufWidth
     local curWidth = 0
     for _, chunk in ipairs(virtText) do
         local chunkText = chunk[1]
         local chunkWidth = vim.fn.strdisplaywidth(chunkText)
         if targetWidth > curWidth + chunkWidth then
             table.insert(newVirtText, chunk)
         else
             chunkText = truncate(chunkText, targetWidth - curWidth)
             local hlGroup = chunk[2]
             table.insert(newVirtText, {chunkText, hlGroup})
             chunkWidth = vim.fn.strdisplaywidth(chunkText)
             -- str width returned from truncate() may less than 2nd argument, need padding
             if curWidth + chunkWidth < targetWidth then
                 suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
             end
             break
         end
         curWidth = curWidth + chunkWidth
     end
     table.insert(newVirtText, {suffix, 'MoreMsg'})
     return newVirtText
 end

 vim.keymap.set('n', 'K', function()
     local winid = require('ufo').peekFoldedLinesUnderCursor()
     if not winid then
         vim.fn.CocActionAsync('definitionHover')
     end
 end)

 require('ufo').setup({
   fold_virt_text_handler = handler
 })

 local builtin = require("statuscol.builtin")
 require("statuscol").setup({
     relculright = true,
     segments = {
         { text = { "%s" }, },
         { text = { builtin.lnumfunc }, },
         { text = { " ", builtin.foldfunc, " " }, },
     }
 })

-- require("statuscol").setup({
--   relculright = true,
--   segments = {
--     {
--       sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
--     },
--     { text = { builtin.lnumfunc }, },
--     { text = { builtin.foldfunc }, },
--     {
--       sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
--     },
--   }
-- })

EOF
