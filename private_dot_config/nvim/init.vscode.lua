-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- remap leader key
-- keymap("n", "<Space>", "", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("lazy").setup({
  spec = {
    --{
    --  "folke/flash.nvim",
    --  event = "VeryLazy",
    --  ---@type Flash.Config
    --  opts = {
    --    continue = true,
    --    modes = {
    --      search = {
    --        enabled = true
    --      },
    --      char = {
    --        jump_labels = true
    --      },
    --    }
    --  },
    --  -- stylua: ignore
    --  keys = {
    --    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    --    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    --    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    --  },
    --},
    { "tpope/vim-surround" },
    { "tpope/vim-commentary" },
    { "tpope/vim-repeat" },
    { "jiangmiao/auto-pairs" },
    { "tpope/vim-endwise" },
    -- {
    -- "nvim-treesitter/nvim-treesitter",
    --   build = ":TSUpdate",
    --   config = function()
    --     require("nvim-treesitter.configs").setup({
    --       ensure_installed = {
    --         "javascript", "typescript", "tsx", "ruby", "java", "lua", "json",
    --       },
    --       highlight = { enable = true },
    --       indent = { enable = true },
    --     })
    --   end
    -- },
    'vim-repeat',
    'ggandor/leap.nvim',
    {
        'ggandor/flit.nvim',
        config = function()
          require('flit').setup {
            multiline = false,
          }
        end,
    },

  },
  -- Colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
})

require('leap').set_default_mappings()

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- removes highlighting after escaping vim search
keymap('n', '<leader><space>', ':nohl<CR>', opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- using VSCode maps instead, couldn't get these working
-- keymap('n', '<C-h>', '<C-w>h', opts)
-- keymap('n', '<C-j>', '<C-w>j', opts)
-- keymap('n', '<C-k>', '<C-w>k', opts)
-- keymap('n', '<C-l>', '<C-w>l', opts)

-- save with enter
keymap('n', '<CR>', ':w<CR>', opts)

-- Resize vertical splits with Ctrl+Arrow
-- keymap('n', '<C-Left>',  ':vertical resize -2<CR>', opts)
-- keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)
-- keymap('n', '<C-Up>',    ':resize -2<CR>',          opts)
-- keymap('n', '<C-Down>',  ':resize +2<CR>',          opts)

-- yank to system clipboard
-- keymap({"n", "v"}, "<leader>y", '"+y', opts)

-- paste from system clipboard
-- keymap({"n", "v"}, "<leader>p", '"+p', opts)

-- paste preserves primal yanked piece
-- keymap("v", "p", '"_dP', opts)


-- call vscode commands from neovim

-- general keymaps
-- keymap({"n", "v"}, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
-- keymap({"n", "v"}, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
-- keymap({"n", "v"}, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
-- keymap({"n", "v"}, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
-- keymap({"n", "v"}, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
-- keymap({"n", "v"}, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
-- keymap({"n", "v"}, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
-- keymap({"n", "v"}, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
-- keymap({"n", "v"}, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
-- keymap({"n", "v"}, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
