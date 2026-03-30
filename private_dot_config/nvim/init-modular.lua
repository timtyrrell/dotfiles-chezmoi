-- Set leader before lazy.nvim setup
vim.g.mapleader = ','

-- Install package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Core settings (before plugins)
require('core.options')
require('core.autocmds')

-- Load plugins via lazy.nvim (auto-discovers lua/plugins/*.lua)
require('lazy').setup('plugins', {
  checker = {
    enabled = false,
    concurrency = nil,
    notify = true,
    frequency = 86400,
    check_pinned = false,
  },
})

-- Keymaps (after plugins are loaded)
require('core.keymaps')
require('core.functions')
