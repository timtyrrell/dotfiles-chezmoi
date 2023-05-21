-- local cmd = vim.cmd
-- local g = vim.g
-- local opt = vim.opt

-- g.mapleader = ","

-- vim.cmd [[packadd packer.nvim]]
-- return require('packer').startup(function(use)
--     use { -- neoclip {{{
--         'AckslD/nvim-neoclip.lua',
--         requires = {'tami5/sqlite.lua', module = 'sqlite'},
--         config = function()
--             require('neoclip').setup{
--                 history = 20,
--                 enable_persistant_history = true,
--             }
--         end
--     } -- }}}
--     use { -- telescope {{{
--         'nvim-telescope/telescope.nvim',
--         wants = {'popup.nvim', 'plenary.nvim'},
--         requires = {
--             {'nvim-lua/popup.nvim'},
--             {'nvim-lua/plenary.nvim'},
--         },
--         cmd = 'Telescope',
--         module = 'telescope',
--         config = function()
--             require('telescope').setup({
--                 defaults = {
--                     dynamic_preview_title = true,
--                 },
--             })
--         end
--     }
-- end)
--
--local Plug = vim.fn['plug#']
--vim.call('plug#begin', '~/.config/nvim/plugged')
--  Plug('nvim-treesitter/nvim-treesitter', {['do']= ':TSUpdate'})
--  Plug 'hrsh7th/cmp-nvim-lsp'
--  Plug 'hrsh7th/cmp-buffer'
--  Plug 'hrsh7th/cmp-path'
--  Plug 'hrsh7th/cmp-cmdline'
--  Plug 'hrsh7th/nvim-cmp'
--  Plug 'L3MON4D3/LuaSnip'
--  Plug 'saadparwaiz1/cmp_luasnip'
--  Plug 'rafamadriz/friendly-snippets'
--  Plug 'onsails/lspkind-nvim'
--  Plug 'numToStr/Comment.nvim'
--  Plug 'jiangmiao/auto-pairs'
--  Plug 'lukas-reineke/indent-blankline.nvim'
--  Plug('akinsho/bufferline.nvim', {  tag = 'v3.*' })
--  Plug 'kyazdani42/nvim-web-devicons'
--  Plug 'kyazdani42/nvim-tree.lua'
--  Plug 'nvim-lualine/lualine.nvim'
--  Plug('folke/tokyonight.nvim', { branch = 'main' })
--  Plug('nvim-treesitter/nvim-treesitter', {['do']= ':TSUpdate'})
--vim.call('plug#end')
----Colorscheme
--vim.cmd[[
--  syntax enable
--  colorscheme tokyonight-night
--]]
----require
--require('plug-setup')
--require('key')

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
  Plug('nvim-treesitter/nvim-treesitter', {['do']= ':TSUpdate'})
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug('folke/tokyonight.nvim', { branch = 'main' })
vim.call('plug#end')
--Colorscheme
vim.cmd[[
  syntax enable
  colorscheme tokyonight-night
]]
--require
require('plug-setup')
require('key')

local cmp = require'cmp'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })


  -- https://gist.github.com/nathanaelcunningham/b47884caecd5fe70cb993f3efda0f7d8
  -- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}


-- https://www.reddit.com/r/neovim/comments/12o2pzq/comment/jggvt2n/?context=3
-- wrap to see what blows up
-- local function safeRequire(module)
-- 	local success, req = pcall(require, module)
-- 	if success then return req end
-- 	vim.cmd.echoerr ("Error loading " .. module)
-- end

-- safeRequire("config.options-and-autocmds")
-- safeRequire("config.theme-config")
-- safeRequire("config.keybindings")
