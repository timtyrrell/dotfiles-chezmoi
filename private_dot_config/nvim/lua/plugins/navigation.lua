return {
  {
    'ggandor/leap.nvim',
    url = 'https://codeberg.org/andyg/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    keys = {
      { 's', '<Plug>(leap-forward)',  mode = { 'n', 'x', 'o' }, noremap = false, desc = 'leap forward' },
      { 'S', '<Plug>(leap-backward)', mode = { 'n', 'x', 'o' }, noremap = false, desc = 'leap backward' },
    },
    config = function()
      local function as_ft(key_specific_args)
        local common_args = {
          inputlen = 1,
          inclusive = true,
          opts = {
            labels = '',
            safe_labels = vim.fn.mode(1):match('o') and '' or nil,
            case_sensitive = true,
          },
        }
        return vim.tbl_deep_extend('keep', common_args, key_specific_args)
      end

      local clever = require('leap.user').with_traversal_keys
      local clever_f = clever('f', 'F')
      local clever_t = clever('t', 'T')

      for key, args in pairs {
        f = { opts = clever_f },
        F = { backward = true, opts = clever_f },
        t = { offset = -1, opts = clever_t },
        T = { backward = true, offset = 1, opts = clever_t },
      } do
        vim.keymap.set({ 'n', 'x', 'o' }, key, function()
          require('leap').leap(as_ft(args))
        end)
      end
    end,
    opts = {
      preview_filter = function(ch0, ch1, ch2)
        return not (
          ch1:match('%s') or
          ch0:match('%a') and ch1:match('%a') and ch2:match('%a')
        )
      end,
    },
  },
  'andymass/vim-matchup',
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup({ nearest_only = true })
    end,
  },
}
