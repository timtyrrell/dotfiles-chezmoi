-- Minimal nvim config for quick_editor.sh popup edits.
-- Used by: git commits/rebases (core.editor in ~/.gitconfig) and Claude Code
-- ($EDITOR/$VISUAL in ~/.claude/settings.json).
-- Launched via: nvim -u ~/.config/nvim/init-quick.lua

vim.opt.number         = true
vim.opt.relativenumber = false
vim.opt.wrap           = true
vim.opt.linebreak      = true
vim.opt.spell          = true
vim.opt.spelllang      = { 'en_us' }
vim.opt.signcolumn     = 'no'
vim.opt.cursorline     = true
vim.opt.scrolloff      = 3
vim.opt.termguicolors  = true
-- No clipboard=unnamedplus: vim-system-copy handles copy/paste via cpy/cv motions.
-- Letting nvim's provider auto-sync every yank fights the plugin's save/restore
-- of @@ and clobbers pbcopy with stale register contents.
vim.opt.undofile       = true
vim.opt.swapfile       = false
vim.opt.conceallevel   = 2
vim.opt.concealcursor  = ''
vim.opt.autoread       = true

local map = vim.keymap.set
map('', 'QQ', ':qa!<CR>', { silent = true, desc = 'Quit all, discard' })
map('', 'QA', ':qa<CR>',  { silent = true, desc = 'Quit all, prompt' })

vim.g.committia_open_only_vim_starting = 1

vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = { 'COMMIT_EDITMSG', 'MERGE_MSG' },
  callback = function(args)
    local path = vim.fn.fnamemodify(args.file, ':p')
    local git_dir = path:match('(.+[\\/]%.bare[\\/]worktrees[\\/][^\\/]+)[\\/]')
    if git_dir then
      local gitdir_file = git_dir .. '/gitdir'
      if vim.fn.filereadable(gitdir_file) == 1 then
        local work_tree = vim.fn.fnamemodify(vim.fn.readfile(gitdir_file)[1], ':h')
        vim.env.GIT_DIR = git_dir
        vim.env.GIT_WORK_TREE = work_tree
      end
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
  { src = 'https://github.com/rhysd/committia.vim' },
  { src = 'https://github.com/hotwatermorning/auto-git-diff' },
  { src = 'https://github.com/christoomey/vim-system-copy' },
})

require('tokyonight').setup({
  style = 'night',
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
  },
  dim_inactive = true,
})
vim.cmd.colorscheme('tokyonight')

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'tokyonight',
  callback = function()
    vim.api.nvim_set_hl(0, 'IncSearch',   { fg = '#292e42', bg = '#bb9af7' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { fg = '#c0caf5', bg = '#292e42' })
  end,
})

require('render-markdown').setup({
  file_types = { 'markdown', 'gitcommit' },
  completions = { lsp = { enabled = false } },
})

vim.cmd([[
  let g:committia_hooks = {}
  function! g:committia_hooks.edit_open(info)
    setlocal spell
    if a:info.vcs ==# 'git' && getline(1) ==# ''
      startinsert
    endif
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
  endfunction
]])

-- Empty buffer → insert mode; pre-filled buffer → stay in normal mode
-- (Claude Code hands us a prefilled buffer; we usually want to read/review, not edit.)
-- Committia handles gitcommit/gitrebase cases itself.
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.bo.filetype == 'gitcommit' or vim.bo.filetype == 'gitrebase' then
      return
    end
    if vim.fn.line('$') == 1 and vim.fn.getline(1) == '' then
      vim.cmd('startinsert')
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'gitcommit' },
  callback = function()
    vim.opt_local.list       = false
    vim.opt_local.linebreak  = true
    vim.opt_local.textwidth  = 72
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function() pcall(vim.treesitter.start) end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function() pcall(vim.treesitter.start, 0, 'markdown') end,
})
