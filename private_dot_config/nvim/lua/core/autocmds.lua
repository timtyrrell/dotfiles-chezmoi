-- Clear cmd line message after 10 seconds
local function empty_message()
  if vim.fn.mode() == 'n' then
    vim.cmd('echon ""')
  end
end

vim.api.nvim_create_autocmd('CmdlineLeave', {
  pattern = ':',
  callback = function()
    vim.defer_fn(empty_message, 10000)
  end,
})

-- Resize/equalize
vim.api.nvim_create_augroup('STUFFS', { clear = true })
vim.api.nvim_create_autocmd({ 'VimResume', 'VimResized' }, {
  group = 'STUFFS',
  callback = function()
    vim.cmd('wincmd =')
  end,
})

-- Only highlight cursorline in current active buffer, when not in insert mode
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  group = 'STUFFS',
  callback = function() vim.opt_local.cursorline = true end,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  group = 'STUFFS',
  callback = function() vim.opt_local.cursorline = false end,
})

-- Go back to previous tab when closing tab
vim.api.nvim_create_autocmd('TabClosed', {
  group = 'STUFFS',
  command = 'tabprevious',
})

-- Keep default CR behaviour for quickfix list
vim.api.nvim_create_augroup('quickfix', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
  group = 'quickfix',
  pattern = 'quickfix',
  callback = function()
    vim.keymap.set('n', '<CR>', '<CR>', { buffer = true })
  end,
})

-- Hot reload: detect external file changes
local function should_check()
  local mode = vim.api.nvim_get_mode().mode
  return not (
    mode:match('[cR!s]')
    or vim.fn.getcmdwintype() ~= ''
  )
end

local function should_reload_buffer(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  local buftype = vim.api.nvim_get_option_value('buftype', { buf = buf })
  local modified = vim.api.nvim_get_option_value('modified', { buf = buf })
  local is_real_file = name ~= '' and not name:match('^%w+://')

  return is_real_file and buftype == '' and not modified
end

local function get_visible_buffers()
  local visible = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    visible[vim.api.nvim_win_get_buf(win)] = true
  end
  return visible
end

-- Filesystem watcher: reload buffers changed on disk in the background
local dir_watcher = require('core.directory-watcher')
dir_watcher.registerOnChangeHandler('hotreload', function(filepath)
  if not should_check() then
    return
  end

  local visible_buffers = get_visible_buffers()
  for buf, _ in pairs(visible_buffers) do
    if vim.api.nvim_buf_get_name(buf) == filepath and should_reload_buffer(buf) then
      vim.cmd('checktime ' .. buf)
    end
  end
end)
dir_watcher.setup()

-- Autocmd-based checktime for focus/buffer switches
vim.api.nvim_create_augroup('randomstuff', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermLeave', 'BufEnter', 'WinEnter', 'CursorHold', 'CursorHoldI' }, {
  group = 'randomstuff',
  callback = function()
    if should_check() then
      vim.cmd('checktime')
    end
  end,
})
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = 'randomstuff',
  pattern = '*',
  callback = function()
    vim.api.nvim_echo({ { 'File changed on disk. Buffer reloaded.', 'WarningMsg' } }, false, {})
  end,
})

-- Filetype overrides
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'randomstuff',
  pattern = { '.eslintrc', '.prettierrc', '.lintstagedrc' },
  callback = function() vim.bo.filetype = 'jsonc' end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'randomstuff',
  pattern = { '*.build', '.env*', 'config.env' },
  callback = function() vim.bo.filetype = 'sh' end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'randomstuff',
  pattern = '*.template',
  callback = function() vim.bo.filetype = 'nginx' end,
})

-- Chezmoi filetype fixes
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'randomstuff',
  pattern = '*gitconfig*',
  callback = function() vim.bo.filetype = 'gitconfig' end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'randomstuff',
  pattern = 'dot_zshrc',
  callback = function() vim.bo.filetype = 'zsh' end,
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'randomstuff',
  pattern = 'dot_tmux.conf',
  callback = function() vim.bo.filetype = 'tmux' end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'randomstuff',
  pattern = { '*.graphql', '*.graphqls', '*.gql' },
  callback = function() vim.bo.filetype = 'graphql' end,
})

vim.api.nvim_create_augroup('Mkdir', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'Mkdir',
  pattern = '*',
  callback = function()
    vim.fn.mkdir(vim.fn.expand('<afile>:p:h'), 'p')
  end,
})

-- Tmux groups
vim.api.nvim_create_augroup('tmuxgroups', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'tmuxgroups',
  pattern = 'tmux',
  callback = function()
    vim.keymap.set('n', 'K', ':call tmux#man()<CR>', { buffer = true, silent = true })
  end,
})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'tmuxgroups',
  pattern = '.tmux.conf',
  command = "execute ':!tmux source-file %'",
})

-- Colors
vim.api.nvim_create_augroup('MyColors', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'MyColors',
  callback = function()
    if vim.g.colors_name == 'tokyonight' then
      vim.api.nvim_set_hl(0, 'IncSearch', { fg = '#292e42', bg = '#bb9af7' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { fg = '#c0caf5', bg = '#292e42' })
      vim.api.nvim_set_hl(0, 'MarkVirtTextHL', { bold = true, fg = '#ffffff', bg = '#f00077' })
    end
  end,
})

-- Highlight TODOs etc
vim.api.nvim_create_autocmd('Syntax', {
  group = 'MyColors',
  pattern = '*',
  callback = function()
    vim.fn.matchadd('Search', [[\v\W\zs<(NOTE|INFO|TODO|FIXME|CHANGED|BUG|HACK|LEARNINGS|TECH|IMPACT)>]])
  end,
})

-- Yarn 2 PnP goto definition support
vim.api.nvim_create_augroup('yarngroup', { clear = true })
vim.api.nvim_create_autocmd('BufReadCmd', {
  group = 'yarngroup',
  pattern = '/zip:*.yarn/cache/*.zip/*',
  callback = function()
    local f = vim.fn.expand('<afile>')
    local b = vim.fn.bufnr('%')
    f = f:gsub('.zip/', '.zip::')
    f = f:gsub('/zip:', 'zipfile:')
    vim.cmd('b #')
    vim.cmd('bd! ' .. b)
    vim.cmd('sil e ' .. f)
    vim.fn['zip#Read'](f, 1)
  end,
})
