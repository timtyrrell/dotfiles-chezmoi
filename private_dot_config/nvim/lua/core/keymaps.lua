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

-- Copilot
map('n', '<Leader>cp', '<cmd>Copilot<CR>', { silent = true })
map('n', '<Leader>ce', '<cmd>Copilot enable<CR>', { silent = true })
map('n', '<Leader>cx', '<cmd>Copilot disable<CR>', { silent = true })
map('i', '<Up>', '<Plug>(copilot-previous)')
map('i', '<Down>', '<Plug>(copilot-next)')
map('i', '<Left>', '<Plug>(copilot-dismiss)')
map('i', '<Right>', "copilot#Accept('<CR>')", { script = true, expr = true, silent = true })
vim.g.copilot_no_tab_map = true

-- vim-printer
vim.g.vim_printer_print_below_keybinding = '<leader>cl'
vim.g.vim_printer_print_above_keybinding = '<leader>cL'
vim.g.vim_printer_items = {
  javascript = "console.log('{$}:', {$});",
  typescriptreact = "console.log('{$}:', {$});",
  typescript = "console.log('{$}:', {$});",
  javascriptreact = "console.log('{$}:', {$});",
  ruby = 'puts "{$}", {$}',
  eruby = '<%= puts "{$}", {$} %>',
  slim = 'puts "{$}", {$}',
}

-- Vimux mappings
map('', '<Leader>vv', ':call v:lua.VimuxZoomInspectRunner()<CR>')
map('', '<Leader>vp', ':VimuxPromptCommand<CR>')
map('', '<Leader>vl', ':VimuxRunLastCommand<CR>')
map('', '<Leader>vi', ':VimuxInspectRunner<CR>')
map('', '<leader>vz', ':VimuxZoomRunner<CR>')
map('', '<Leader>vq', ':VimuxCloseRunner<CR>')
map('', '<Leader>v<C-l>', ':VimuxClearTerminalScreen<CR>')
map('', '<Leader>vc', ':VimuxClearRunnerHistory<CR>')
map('', '<Leader>vx', ':VimuxInterruptRunner<CR>')

-- REPL usage
map('v', '<leader>vs', '"vy :call v:lua.VimuxSlime()<CR>')
map('n', '<leader>vs', 'vip<leader>vs<CR>')
map('n', '<leader>vb', 'ggVG<leader>vs<CR>')
map('n', '<Leader>vf', ':call VimuxRunCommand("clear; node " . bufname("%"))<CR>')

-- Dadbod
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_force_echo_notifications = 1

-- Treehopper
map('o', 'm', "<Cmd>lua require('tsht').nodes()<CR>", { silent = true })
map('x', 'm', ":lua require('tsht').nodes()<CR>", { silent = true })

-- Open browser
vim.g.openbrowser_default_search = 'duckduckgo'
map('n', 'gx', '<Plug>(openbrowser-smart-search)')
map('v', 'gx', '<Plug>(openbrowser-smart-search)')

-- Tmux navigator
vim.g.tmux_navigator_disable_when_zoomed = 1

-- Fugitive gitlab
vim.g.fugitive_gitlab_domains = { 'https://git.lab.smartsheet.com' }

-- NvimTree
map('n', '<leader>ee', ':NvimTreeFindFile<CR>', { silent = true })
map('n', '<leader>et', ':NvimTreeToggle<CR>', { silent = true })

-- Browser search
map('n', '<Leader>bs', '<Plug>SearchNormal', { silent = true })
map('v', '<Leader>bs', '<Plug>SearchVisual', { silent = true })
vim.g.browser_search_default_engine = 'duckduckgo'

-- Indent-blankline v2 settings
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_char = '▏'
vim.g.indent_blankline_filetype_exclude = { 'checkhealth', 'NvimTree', 'vim-plug', 'man', 'help', 'lspinfo', '', 'GV', 'git', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile', 'quickfix', 'prompt' }
vim.g.indent_blankline_bufname_exclude = { 'README.md', '.*%.py' }
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_show_current_context_start = true
vim.g.indent_blankline_context_patterns = { 'declaration', 'expression', 'pattern', 'primary_expression', 'statement', 'switch_body', 'def', 'class', 'return', '^func', 'method', '^if', 'while', 'jsx_element', 'for', 'object', 'table', 'block', 'arguments', 'else_clause', '^jsx', 'try', 'catch_clause', 'import_statement', 'operation_type', 'with', 'except', 'arguments', 'argument_list', 'dictionary', 'element', 'tuple' }
-- Disable in diff mode
if vim.opt.diff:get() then
  vim.g.indent_blankline_enabled = false
end

-- Markdown preview
vim.g.mkdp_filetypes = { 'markdown', 'mermaid' }
map('n', '<leader>mp', '<Plug>MarkdownPreview')
map('n', '<leader>ms', '<Plug>MarkdownPreviewStop')

-- Coc config
vim.g.coc_enable_locationlist = 0
vim.g.coc_global_extensions = {
  'coc-basedpyright',
  'coc-css',
  'coc-cssmodules',
  'coc-db',
  'coc-docker',
  'coc-emmet',
  'coc-eslint',
  'coc-git',
  'coc-go',
  'coc-html',
  'coc-java',
  'coc-jest',
  'coc-json',
  'coc-lists',
  'coc-markdownlint',
  'coc-marketplace',
  'coc-pairs',
  'coc-prettier',
  'coc-react-refactor',
  '@yaegassy/coc-ruff',
  'coc-sh',
  'coc-snippets',
  'coc-styled-components',
  'coc-sumneko-lua',
  'coc-svg',
  'coc-swagger',
  'coc-tsserver',
  'coc-vimlsp',
  'coc-webpack',
  'coc-yaml',
  'coc-yank',
}

-- Use C-j, C-k to move in completion list
map('i', '<C-j>', function()
  return vim.fn['coc#pum#visible']() == 1 and vim.fn['coc#pum#next'](1) or '<Tab>'
end, { expr = true })
map('i', '<C-k>', function()
  return vim.fn['coc#pum#visible']() == 1 and vim.fn['coc#pum#prev'](1) or '<S-Tab>'
end, { expr = true })

-- Coc snippet navigation
vim.g.coc_snippet_next = '<Tab>'
vim.g.coc_snippet_prev = '<S-Tab>'

-- Use <c-space> to trigger completion
map('i', '<C-space>', 'coc#refresh()', { silent = true, expr = true })

-- Use <cr> to confirm completion
map('i', '<CR>', function()
  if vim.fn['coc#pum#visible']() == 1 then
    return vim.fn['coc#pum#confirm']()
  end
  return '<C-g>u<CR><C-r>=coc#on_enter()<CR>'
end, { expr = true, silent = true })

-- Coc diagnostic navigation
map('n', '[d', '<Plug>(coc-diagnostic-prev)', { silent = true })
map('n', ']d', '<Plug>(coc-diagnostic-next)', { silent = true })
map('n', '[D', '<Plug>(coc-diagnostic-prev-error)', { silent = true })
map('n', ']D', '<Plug>(coc-diagnostic-next-error)', { silent = true })

-- Coc git navigation
map('n', '[c', '<Plug>(coc-git-prevchunk)')
map('n', ']c', '<Plug>(coc-git-nextchunk)')
map('n', '[g', '<Plug>(coc-git-prevconflict)')
map('n', ']g', '<Plug>(coc-git-nextconflict)')

-- Coc git operations
map('n', '<space>ghs', '<cmd>CocCommand git.chunkStage<cr>', { silent = true })
map('n', '<space>ghu', '<cmd>CocCommand git.chunkUnstage<cr>', { silent = true })
map('n', '<space>gu', '<cmd>CocCommand git.chunkUndo<cr>', { silent = true })
map('v', '<space>gu', '<cmd>CocCommand git.chunkUndo<cr>', { silent = true })
map('n', '<space>gb', '<cmd>CocCommand git.showBlameDoc<cr>', { silent = true })
map('n', '<space>gi', '<Plug>(coc-git-chunkinfo)', { silent = true })
map('o', 'ig', '<Plug>(coc-git-chunk-inner)', { silent = true })
map('x', 'ig', '<Plug>(coc-git-chunk-inner)', { silent = true })

-- Coc LSP
map('n', 'gd', '<Plug>(coc-definition)', { silent = true })
map('n', 'gD', '<Plug>(coc-declaration)', { silent = true })
map('n', 'gr', '<Plug>(coc-references)', { silent = true })
map('n', 'gu', '<Plug>(coc-references-used)', { silent = true })
map('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
map('n', 'gm', '<Plug>(coc-implementation)', { silent = true })

-- Coc rename/refactor
map('n', '<space>cn', '<Plug>(coc-rename)')
map('n', '<space>cb', '<Plug>(coc-refactor)')
map('n', '<space>re', '<Plug>(coc-codeaction-refactor)', { silent = true })
map('x', '<space>rs', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })
map('n', '<space>rs', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })

-- Coc code actions
map('n', '<space>cf', '<Plug>(coc-fix-current)')
map('n', '<space>ce', '<Plug>(coc-codelens-action)')
map('n', '<space>cc', '<Plug>(coc-codeaction-cursor)')
map('n', '<space>cS', '<Plug>(coc-codeaction-source)')
map('n', '<space>cl', '<Plug>(coc-codeaction-line)')
map('v', '<space>cs', '<Plug>(coc-codeaction-selected)')
map('n', '<space>cs', '<Plug>(coc-codeaction-selected)')

-- Coc outline and misc
map('n', '<space>co', '<Cmd>CocOutline<cr>')
map('n', '<space>cr', '<Cmd>CocRestart<CR>')

-- Coc commands
vim.api.nvim_create_user_command('TscGTSD', function() vim.fn.CocAction('runCommand', 'tsserver.goToSourceDefinition') end, {})
vim.api.nvim_create_user_command('Tsc', function() vim.fn.CocAction('runCommand', 'tsserver.watchBuild') end, {})
vim.api.nvim_create_user_command('Prettier', ':CocCommand prettier.formatFile', {})
vim.api.nvim_create_user_command('Format', function() vim.fn.CocActionAsync('format') end, {})
vim.api.nvim_create_user_command('Fold', function(opts) vim.fn.CocAction('fold', opts.args) end, { nargs = '?' })
vim.api.nvim_create_user_command('OR', function() vim.fn.CocActionAsync('runCommand', 'editor.action.organizeImport') end, {})
vim.api.nvim_create_user_command('CHI', function() vim.fn.CocActionAsync('runCommand', 'document.showIncomingCalls') end, {})
vim.api.nvim_create_user_command('CHO', function() vim.fn.CocActionAsync('runCommand', 'document.showOutgoingCalls') end, {})

-- Coc call hierarchy
map('n', '<space>cki', '<Cmd>CHI<cr>')
map('n', '<space>cko', '<Cmd>CHO<cr>')

-- Coc scroll float
map('n', '<C-f>', function() return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](1) or '<C-f>' end, { silent = true, nowait = true, expr = true })
map('n', '<C-b>', function() return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](0) or '<C-b>' end, { silent = true, nowait = true, expr = true })
map('i', '<C-f>', function() return vim.fn['coc#float#has_scroll']() == 1 and '<C-r>=coc#float#scroll(1)<CR>' or '<Right>' end, { silent = true, nowait = true, expr = true })
map('i', '<C-b>', function() return vim.fn['coc#float#has_scroll']() == 1 and '<C-r>=coc#float#scroll(0)<CR>' or '<Left>' end, { silent = true, nowait = true, expr = true })
map('v', '<C-f>', function() return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](1) or '<C-f>' end, { silent = true, nowait = true, expr = true })
map('v', '<C-b>', function() return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](0) or '<C-b>' end, { silent = true, nowait = true, expr = true })

-- K for documentation
map('n', 'K', ':call v:lua.ShowDocumentation()<CR>', { silent = true })

-- Coc transparent cursor fix
vim.g.coc_disable_transparent_cursor = 1

-- Coc actions
map('n', '<space>an', '<Cmd>CocNext<CR>', { silent = true, nowait = true })
map('n', '<space>ap', '<Cmd>CocPrev<CR>', { silent = true, nowait = true })

vim.api.nvim_create_user_command('Swagger', ':CocCommand swagger.render', {})

-- Coc-fzf
vim.g.coc_fzf_opts = { '--layout=reverse' }
vim.g.coc_fzf_preview = 'right:50%'
vim.g.coc_fzf_preview_fullscreen = 0
vim.g.coc_fzf_preview_toggle_key = '\\'

map('n', '<space>zo', '<Cmd>CocFzfList outline<CR>', { silent = true, nowait = true })
map('n', '<space>zy', '<Cmd>CocFzfList yank<CR>', { silent = true, nowait = true })
map('n', '<leader>zf', ':call v:lua.coc_qf_diagnostic()<CR>', { silent = true, nowait = true })

-- Coc autocmds
vim.api.nvim_create_augroup('CocGroup', { clear = true })
vim.api.nvim_create_autocmd('CursorHold', {
  group = 'CocGroup',
  pattern = '*',
  callback = function() vim.fn.CocActionAsync('highlight') end,
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'CocGroup',
  pattern = { 'typescript', 'json' },
  callback = function() vim.bo.formatexpr = "CocActionAsync('formatSelected')" end,
})
vim.api.nvim_create_autocmd('User', {
  group = 'CocGroup',
  pattern = 'CocJumpPlaceholder',
  callback = function() vim.fn.CocActionAsync('showSignatureHelp') end,
})
vim.api.nvim_create_autocmd('User', {
  group = 'CocGroup',
  pattern = 'CocQuickfixChange',
  command = 'CocList --normal quickfix',
})
vim.api.nvim_create_autocmd('CompleteDone', {
  group = 'CocGroup',
  callback = function()
    if vim.fn.pumvisible() == 0 then vim.cmd('pclose') end
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'CocGroup',
  pattern = 'TelescopePrompt',
  callback = function() vim.b.coc_pairs_disabled = { "'" } end,
})

-- Coc highlights
vim.api.nvim_set_hl(0, 'CocHighlightText', { link = 'TabLineSel', default = true })
vim.api.nvim_set_hl(0, 'CocCodeLens', { link = 'LspCodeLens', default = true })
vim.api.nvim_set_hl(0, 'CocPumSearch', { link = 'Statement', default = true })

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

-- Fzf settings
vim.g.fzf_vim = { grep_multi_line = 2 }
vim.g.fzf_action = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-x'] = 'split',
  ['ctrl-v'] = 'vsplit',
}
vim.g.fzf_layout = { window = { width = 0.9, height = 0.7 } }

-- File finding
map('n', '<Leader>ff', '<cmd>Files<CR>', { silent = true })
map('n', '<Leader>fF', ':Files ', { silent = true })

-- Rails specific
map('n', '<Leader>ea', ':Files app/assets<CR>', { silent = true })
map('n', '<Leader>ec', ':Files app/controllers<CR>', { silent = true })
map('n', '<Leader>eh', ':Files app/helpers<CR>', { silent = true })
map('n', '<Leader>ei', ':Files config/initializers<CR>', { silent = true })
map('n', '<Leader>ej', ':Files app/javascript<CR>', { silent = true })
map('n', '<Leader>em', ':Files app/models<CR>', { silent = true })
map('n', '<Leader>es', ':Files spec<CR>', { silent = true })
map('n', '<Leader>ev', ':Files app/views<CR>', { silent = true })

map('n', '<Leader>fT', '<cmd>Windows<CR>', { silent = true })
map('n', '<Leader>fb', ':Buffers<CR>', { silent = true })
vim.g.fzf_buffers_jump = 1
map('n', '<leader>bx', ':BD<CR>', { silent = true })

-- Telescope mappings
map('n', '<leader>fB', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", { silent = true })
map('n', '<Leader>fl', '<cmd>RgLines<CR>', { silent = true })
map('n', '<leader>fz', "<cmd>lua require('telescope.builtin').live_grep({ prompt_title = 'find string in open buffers...', grep_open_files = true })<cr>", { silent = true })
map('n', '<leader>fd', "<cmd>lua require('telescope.builtin').find_files({ cwd = require'telescope.utils'.buffer_dir() })<cr>", { silent = true })
map('n', '<Leader>fL', ':Lines<CR>', { silent = true })
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').command_history()<cr>", { silent = true })
map('n', '<leader>fH', "<cmd>lua require('telescope.builtin').oldfiles()<cr>", { silent = true })
map('n', '<leader>fS', "<cmd>lua require('telescope.builtin').search_history()<cr>", { silent = true })
map('n', '<Leader>fg', "<cmd>lua require('telescope.builtin').git_status()<cr>", { silent = true })
map('n', '<Leader>fc', ':BCommits<CR>', { silent = true })
map('n', '<Leader>fC', ':Commits<CR>', { silent = true })
map('n', '<leader>fm', "<cmd>lua require('telescope.builtin').marks()<cr>", { silent = true })
map('n', '<leader>fM', "<cmd>lua require('telescope.builtin').keymaps()<cr>", { silent = true })
map('n', '<leader>fs', "<cmd>lua require('telescope.builtin').spell_suggest()<cr>", { silent = true })
map('n', '<leader>fr', "<cmd>lua require('telescope.builtin').resume()<cr>", { silent = true })

-- Rg
map('n', '<Leader>rw', ':RgLines <C-R><C-W><CR>', { silent = true })
map('n', '<leader>rd', ':RGdir ')

-- Telescope extras
map('n', '<leader>te', '<cmd>Telescope<cr>')
map('n', '<leader>tu', '<cmd>Telescope undo<cr>')
map('n', '<leader>fn', '<cmd>Telescope node_modules list<cr>')
map('n', '<leader>ti', '<cmd>Telescope import<cr>')

-- Unhighlight search
map('', '<Leader><space>', ':nohl<cr>')

-- hlslens: do not jump from item on * search
map('n', '*', "m`:keepjumps normal! *``<cr><Cmd>lua require('hlslens').start()<CR>", { silent = true })
map('n', 'n', "<Cmd>execute('normal! ' . v:count1 . 'nzz')<CR><Cmd>lua require('hlslens').start()<CR>", { silent = true })
map('n', 'N', "<Cmd>execute('normal! ' . v:count1 . 'Nzz')<CR><Cmd>lua require('hlslens').start()<CR>", { silent = true })

-- Spectre
map('n', '<leader>S', "<cmd>lua require('spectre').open()<CR>")
map('n', '<leader>sw', "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
map('v', '<leader>s', "<esc>:lua require('spectre').open_visual()<CR>")
map('n', '<leader>sp', "viw:lua require('spectre').open_file_search()<cr>")

-- Ack
vim.g.ackprg = 'rg --vimgrep'
vim.cmd([[cnoreabbrev Ack Ack!]])
map('n', '<leader><bs>', ':Ack! <C-R><C-W><CR>')
map('n', '<space><bs>', ':AckWindow! <C-R><C-W><CR>')

-- vim-matchup
vim.g.matchup_matchparen_offscreen = { method = 'popup' }
vim.g.matchup_text_obj_enabled = 0

-- Toggle quickfix
map('n', '<Leader>qq', '<Plug>window:quickfix:loop')

-- Projectionist
vim.g.projectionist_ignore_term = 1
vim.g.rails_projections = {
  ['app/views/*.html.slim'] = {
    type = 'view',
    alternate = 'app/controllers/{dirname}_controller.rb',
  },
}
vim.g.projectionist_heuristics = {
  ['package.json'] = {
    ['*.js'] = {
      alternate = {
        '{dirname}/{basename}.test.js',
        '{dirname}/../{basename}.js',
        '{dirname}/__tests__/{basename}.js',
        '{dirname}/__tests__/{basename}.test.js',
      },
      related = {
        '{dirname}/{basename}.module.scss',
        '{dirname}/styles/{basename}.module.scss',
      },
      type = 'jssource',
    },
    ['*.test.js'] = {
      alternate = { '{dirname}/{basename}.js', '{dirname}/../{basename}.js' },
      type = 'jstest',
    },
    ['*.ts'] = {
      alternate = {
        '{dirname}/{basename}.test.ts',
        '{dirname}/../{basename}.ts',
        '{dirname}/__tests__/{basename}.ts',
        '{dirname}/__tests__/{basename}.test.ts',
        '{dirname}/../../__tests__/{basename}.test.ts',
        '{dirname}/../../__tests__/api/{basename}.test.ts',
      },
      related = {
        '{dirname}/{basename}.module.scss',
        '{dirname}/styles/{basename}.module.scss',
      },
      type = 'tssource',
    },
    ['*.test.ts'] = {
      alternate = {
        '{dirname}/{basename}.ts',
        '{dirname}/../{basename}.ts',
        '{dirname}/../../pages/{basename}.ts',
        '{dirname}/../../pages/api/{basename}.ts',
      },
      type = 'tstest',
    },
    ['*.jsx'] = {
      alternate = {
        '{dirname}/{basename}.test.jsx',
        '{dirname}/__tests__/{basename}.jsx',
        '{dirname}/__tests__/{basename}.test.jsx',
        '{dirname}/../{basename}.jsx',
      },
      related = {
        '{dirname}/{basename}.module.scss',
        '{dirname}/styles/{basename}.module.scss',
      },
      type = 'jsxsource',
    },
    ['*.test.jsx'] = {
      alternate = { '{dirname}/{basename}.jsx', '{dirname}/../{basename}.jsx' },
      type = 'jsxtest',
    },
    ['*.tsx'] = {
      alternate = {
        '{dirname}/{basename}.test.tsx',
        '{dirname}/../{basename}.tsx',
        '{dirname}/__tests__/{basename}.tsx',
        '{dirname}/__tests__/{basename}.test.tsx',
        '{dirname}/../../__tests__/{basename}.test.tsx',
        '{dirname}/../../__tests__/api/{basename}.test.tsx',
      },
      related = {
        '{dirname}/{basename}.module.scss',
        '{dirname}/styles/{basename}.module.scss',
      },
      type = 'tsxsource',
    },
    ['*.test.tsx'] = {
      alternate = {
        '{dirname}/{basename}.tsx',
        '{dirname}/../{basename}.tsx',
        '{dirname}/../../pages/{basename}.tsx',
        '{dirname}/../../pages/api/{basename}.tsx',
      },
      type = 'tsxtest',
    },
    ['*.scss'] = {
      alternate = {
        '{dirname}/{basename}.js',
        '{dirname}/{basename}.jsx',
        '{dirname}/{basename}.ts',
        '{dirname}/{basename}.tsx',
        '{dirname}/../{basename}.js',
        '{dirname}/../{basename}.jsx',
        '{dirname}/../{basename}.ts',
        '{dirname}/../{basename}.tsx',
      },
      type = 'scss',
    },
    ['package.json'] = {
      alternate = { 'package-lock.json', 'yarn.lock' },
    },
    ['package-lock.json'] = { alternate = 'package.json' },
    ['yarn.lock'] = { alternate = 'package.json' },
  },
}

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

-- Git (fugitive) mappings
map('n', '<leader>gV', ':GV --first-parent -100<cr>')
map('n', '<leader>gv', ':GV! -100<cr>')
map('n', '<leader>gb', ':Git blame<cr>')
map('n', '<leader>gB', ':%Git blame<cr>')
map('n', '<leader>gd', ':Gdiff<cr>')
map('n', '<leader>gt', '<cmd>Git difftool --name-only<CR>', { silent = true })
map('n', '<leader>gT', '<cmd>Git difftool<CR>', { silent = true })
map('n', '<leader>gl', ':Gclog -- % -100<cr>')
map('n', '<leader>gL', ':Gclog -100<cr>')
map('v', '<leader>gL', ':Gclog -100<cr>')
map('n', '<Leader>ge', ':Gedit <bar> only<CR>', { silent = true })
map('n', '<leader>gr', ':Gread<cr>:noautocmd update<cr>')
map('n', '<leader>gg', ':Glgrep! -q ')
map('n', '<Leader>g/', ':Glrep! -Hnri --quiet ')
map('n', '<Leader>g?', ':Git! log --grep=')
map('n', '<Leader>gS', ':Git! log -S ')
map('n', '<Leader>g*', ':Glgrep! -Hnri --quiet <C-r>=expand("<cword>")<CR><CR>')
map('n', '<leader>gc', '<cmd>Git commit<CR>', { silent = true })
map('n', '<Leader>gP', '<cmd>Git -p push<CR>', { silent = true })
map('n', '<Leader>gp', '<cmd>Git -p pull<CR>', { silent = true })
map('n', '<Leader>gf', '<cmd>Git -p fetch<CR>', { silent = true })
map('v', '<Leader>Gb', ':GBrowse<CR>')
map('n', '<Leader>Gb', ':.GBrowse<CR>')
map('v', '<Leader>GB', ':GBrowse!<CR>')
map('n', '<Leader>GB', ':.GBrowse!<CR>')
map('n', '<Leader>go', '<cmd>GBrowse HEAD<cr>')
map('n', '<Leader>gw', '<cmd>Gwrite<CR>', { silent = true })
map('n', '<Leader>gW', '<cmd>Gwrite!<CR>', { silent = true })

-- Fugitive extensions
vim.api.nvim_create_augroup('fugitive_ext', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'fugitive_ext',
  pattern = 'fugitiveblame',
  callback = function()
    map('n', '<leader>Gb', function()
      vim.cmd(':GBrowse ' .. vim.fn.expand('<cword>'))
    end, { buffer = true })
  end,
})

-- Git status in new tab
map('n', '<leader>gs', ':tab Git<cr>:G<cr>/^M\\s<cr>:let @/=""<cr>', { silent = true })

-- Put changed file names from previous commit into quickfix
vim.api.nvim_create_user_command('Gshow', function(opts)
  vim.fn.setqflist(vim.tbl_map(function(f)
    return { filename = f, lnum = 1 }
  end, vim.fn.systemlist("git show --pretty='' --name-only " .. (opts.args or ''))))
end, { nargs = '?', bar = true })

-- Diffview
map('n', '<leader>dvm', '<Cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>')
map('n', '<leader>dvp', '<Cmd>DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges<cr>')
map('n', '<leader>dvo', '<cmd>DiffviewOpen<cr>')
map('n', '<leader>dvf', '<Cmd>DiffviewFileHistory %<cr>')
map('n', '<leader>dvF', '<Cmd>DiffviewFileHistory<cr>')
map('n', '<leader>dvl', '<Cmd>DiffviewOpen HEAD~1<cr>')
map('n', '<leader>dvh', '<Cmd>DiffviewFileHistory --range=origin/HEAD..HEAD<cr>')
map('v', '<leader>dvh', "<Cmd>'<,'>DiffviewFileHistory<CR>")

-- Committia
vim.g.committia_open_only_vim_starting = 1
vim.g.committia_hooks = {}
vim.g.committia_hooks.edit_open = function(info)
  vim.opt_local.spell = true
  if info.vcs == 'git' and vim.fn.getline(1) == '' then
    vim.cmd('startinsert')
  end
  map('i', '<C-n>', '<Plug>(committia-scroll-diff-down-half)', { buffer = true })
  map('i', '<C-p>', '<Plug>(committia-scroll-diff-up-half)', { buffer = true })
end

-- Diffconflicts
map('n', '<leader>dcc', ':DiffConflicts<cr>', { silent = true })
map('n', '<leader>dch', ':DiffConflictsShowHistory<cr>', { silent = true })
map('n', '<leader>dcb', ':DiffConflictsWithHistory<cr>', { silent = true })
map('n', '<leader>dcu', ':diffupdate<cr>', { silent = true })
map('n', '<leader>dcs', ':cq<cr>', { silent = true })

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

-- Close-buffers
map('', '<leader>bdo', ':BDelete other<CR>')
map('', '<leader>bdh', ':BDelete hidden<CR>')
map('', '<leader>bda', ':BDelete all<CR>')
map('', '<leader>bdt', ':BDelete this<CR>')
map('', '<leader>bdn', ':BDelete nameless<CR>')

-- vim-test
vim.g['test#ruby#rspec#executable'] = 'bundle exec rspec'
vim.g['test#strategy'] = 'vimux'
map('n', '<leader>tt', ':TestNearest<CR>', { silent = true })
map('n', '<leader>tf', ':TestFile<CR>', { silent = true })
map('n', '<leader>tl', ':TestLast<CR>', { silent = true })
map('n', '<leader>tv', ':TestVisit<CR>', { silent = true })
-- Note: <leader>ts conflicts with 'tab sp' above — keeping both as original
vim.g['test#typescriptreact#jest#options'] = {
  nearest = '--backtrace',
  file = '--format documentation',
  suite = '--tag ~slow',
}

-- Zen mode
map('n', '<leader>zm', ':ZenMode<CR>')

-- Claude prompt (visual mode)
map('v', '<leader>va', [[:<C-u>PromptClaudeWithLocation<CR>]])

-- Fzf mappings/commands
map('n', '<leader>fj', ':Jumps<CR>', { silent = true })
map('n', '<leader>fJ', ':Changes<CR>', { silent = true })
map('n', '<tab><tab>', '<plug>(fzf-maps-n)')
map('x', '<tab><tab>', '<plug>(fzf-maps-x)')
map('o', '<tab><tab>', '<plug>(fzf-maps-o)')
map('i', '<c-x><c-p>', '<plug>(fzf-complete-path)')
map('i', '<c-x><c-k>', '<plug>(fzf-complete-word)')
map('i', '<c-x><c-l>', '<plug>(fzf-complete-line)')

vim.g.fzf_history_dir = '~/.local/share/fzf-history'

-- import_cost
vim.g.import_cost = { package_manager = 'yarn' }

-- jsx colors
vim.g.vim_jsx_pretty_colorful_config = 1
