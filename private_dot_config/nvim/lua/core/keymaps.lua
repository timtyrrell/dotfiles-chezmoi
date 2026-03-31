local map = vim.keymap.set

-- Command line navigation
map('c', '<C-n>', function()
  return vim.fn.wildmenumode() == 1 and '<C-n>' or '<Down>'
end, { expr = true })
map('c', '<C-p>', function()
  return vim.fn.wildmenumode() == 1 and '<C-p>' or '<Up>'
end, { expr = true })

-- Make <C-p>/<C-n> act like <Up>/<Down> in cmdline mode
map('c', '<C-p>', '<Up>')
map('c', '<C-n>', '<Down>')
map('c', '<Up>', '<C-p>')
map('c', '<Down>', '<C-n>')

-- Use c-k/j to navigate cmdline menu
map('c', '<C-k>', '<Left>')
map('c', '<C-j>', '<Right>')

-- Display line movements unless preceded by a count
-- Also recording jump points for movements larger than five lines
map('n', 'j', function()
  if vim.v.count > 0 then
    return (vim.v.count > 5 and "m'" .. vim.v.count or '') .. 'j'
  end
  return 'gj'
end, { expr = true })

map('n', 'k', function()
  if vim.v.count > 0 then
    return (vim.v.count > 5 and "m'" .. vim.v.count or '') .. 'k'
  end
  return 'gk'
end, { expr = true })

-- Dot repetition over visual line selections
map('x', '.', ':norm.<CR>')

-- Run macro over visual lines (using qq to record)
map('x', 'Q', ":'<,'>:normal @q<CR>")

-- Overload @ to execute macro avoiding autocmds
map('x', '@', [[<Cmd>execute "noautocmd '<,'>norm! " . v:count1 . "@" . getcharstr()<CR>]])

-- Save with Enter except in quickfix buffers
map('n', '<CR>', function()
  if vim.bo.buftype == 'quickfix' then
    return '<CR>'
  end
  return ':write<CR>'
end, { expr = true, silent = true })

-- Train myself to use better commands
map('', 'QQ', ':qa!<CR>')
map('', 'QA', ':qa<CR>')
vim.cmd([[cabbrev q! use ZQ]])

-- Chezmoi apply
map('n', '<Leader>ca', ':split | terminal chezmoi -v apply<CR>:startinsert<CR>')

-- Vim config reload
map('n', '<leader>vr', function()
  vim.cmd('source $MYVIMRC')
  require('notify')('vim config reloaded!')
end, { silent = true })

-- Toggle spell checking
map('n', '<leader>ss', ':set spell!<CR>', { silent = true })
map('n', 'z=', ':call v:lua.FzfSpell()<CR>')
map('n', '<leader>sz', ':call v:lua.FzfSpell()<CR>', { silent = true })

-- Split windows
map('n', '<C-w>-', '<cmd>new<cr>')
map('n', '<C-w><bar>', '<cmd>vnew<cr>')

-- File path helpers
map('n', '<leader>ef', ':call v:lua.InsertFilePath()<CR>')
map('n', '<Leader>ep', ':e <C-R>=expand(\'%:p:h\') . \'/\' <CR>')
map('n', '<leader>eb', ':tabedit <C-r>=expand("%:p:h")<CR>/')
map('n', '<leader>er', ':e <C-R>=expand("%:r")."."<CR>')

-- Switch CWD to the directory of the open buffer
map('n', '<leader>cd', ':cd %:p:h<cr>:pwd<cr>')
map('n', '<leader>cf', ':cd %:p:h<cr>')

-- Backspace to ciw
map('n', '<BS>', 'ciw')

-- Open file under cursor anywhere on line
map('n', 'gf', '^f/gf')

-- Set isfname
vim.opt.isfname:remove('=')

-- Open file under cursor in vertical split
map('', '<C-w>f', '<C-w>vgf')

-- Hide the command history buffer
map('n', 'q:', '<nop>')

-- Format json
map('n', '<Leader>jj', ':set ft=json<CR>:%!jq .<CR>', { silent = true })

-- Juggling with jumps
map('n', "'", '`')

-- Indent/dedent pasted text
map('n', '<leader><', 'V`]<')
map('n', '<leader>>', 'V`]>')

-- Reverse C-r meanings in insert mode
map('i', '<C-r>', '<C-r><C-o>')
map('i', '<C-r><C-o>', '<C-r>')

-- Reselect pasted text
map('n', 'gp', '`[v`]')

-- Text object: line
map('x', 'al', '<Plug>(textobj-line-a)')
map('o', 'al', '<Plug>(textobj-line-a)')
map('x', 'il', '<Plug>(textobj-line-i)')
map('o', 'il', '<Plug>(textobj-line-i)')

-- Character-based text objects: i_ a_ i. a. etc
for _, char in ipairs({ '_', '.', ':', ',', ';', '|', '/', '\\', '*', '+', '-', '#' }) do
  local escaped = char
  if char == '|' then escaped = '<bar>' end
  if char == '\\' then escaped = '<bslash>' end
  map('x', 'i' .. char, string.format(':<C-u>normal! T%svt%s<CR>', char, char))
  map('o', 'i' .. char, string.format(':normal vi%s<CR>', char))
  map('x', 'a' .. char, string.format(':<C-u>normal! F%svf%s<CR>', char, char))
  map('o', 'a' .. char, string.format(':normal va%s<CR>', char))
end

-- Don't include leading whitespace for quotes
map('o', "a'", "2i'")
map('o', 'a"', '2i"')
map('x', "a'", "2i'")
map('x', 'a"', '2i"')

-- Yank helpers
map('n', '<leader>yf', ':let @"=expand("%:t")<CR>')
map('n', '<leader>yp', ':let @"=expand("%:p")<CR>')
map('n', '<leader>yn', ':let @"=expand("%:p").":".getpos(\'.\')[1]<CR>')

-- Unhighlight search
map('', '<Leader><space>', ':nohl<cr>')

-- Toggle folds
map('n', '<space><space>', 'za')
map('v', '<space><space>', 'za')

-- Search and replace
map('v', '<leader>rs', '"9y:%s/<c-r>9//g<left><left>')
map('n', '<leader>rs', ':%s/\\<<C-r>=expand("<cword>")<CR>\\>/')
map('v', '<leader>rl', '"9y:s/<c-r>9//g<left><left>')
map('n', '<leader>rl', 'viw"9y:s/<c-r>9//g<left><left>')

-- Replace current word (and . for next one)
map('n', 'cn', '*``cgn')
map('n', 'cN', '*``cgN')
map('n', 'c.', [[:call setreg('/',substitute(@", '\%x00', '\\n', 'g'))<cr>:exec printf("norm %sgn%s", v:operator, v:operator != 'd' ? '<c-a>':'')<cr>]])

-- Operate on "last motion"
map('x', 'ik', '`]o`[')
map('o', 'ik', '<Cmd>normal vik<cr>')
map('o', 'ak', '<Cmd>normal vikV<cr>')
map('o', 'b', 'vb')

-- Only search within visual selection
map('x', '/', '<C-\\><C-n>`</\\%V', { desc = 'Search forward within visual selection' })
map('x', '?', '<C-\\><C-n>`>?\\%V', { desc = 'Search backward within visual selection' })

-- Search and replace cword (Lua version)
map('n', '<Leader>sr', ':%s/<C-r><C-w>//gc<Left><Left><Left>', { silent = false, desc = 'search and replace cword' })
map('v', '<Leader>sr', 'y:%s/<C-R>"//gc<Left><Left><Left>', { silent = false, desc = 'search and replace selection' })

-- Tabs and buffers
map('n', '<C-n>', ':bnext<CR>', { silent = true })
map('n', '<C-p>', ':bprev<CR>', { silent = true })
map('n', '<leader>tc', ':tabclose<cr>')
map('n', '<leader>tn', ':tabnew<cr>')
map('n', '<leader>ts', ':tab sp<cr>')
map('n', '<leader>to', ':tabonly<cr>')
map('n', '<leader>tmh', ':-tabmove<CR>')
map('n', '<leader>tml', ':+tabmove<CR>')
map('n', '<leader>tmm', ':tabedit %<CR>')
for i = 1, 9 do
  map('n', '<leader>' .. i, i .. 'gt')
end
map('n', '<leader>0', ':tablast<CR>')

-- Claude prompt (visual mode)
map('v', '<leader>va', [[:<C-u>PromptClaudeWithLocation<CR>]])
