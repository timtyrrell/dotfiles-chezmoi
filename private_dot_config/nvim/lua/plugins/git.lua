return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'shumphrey/fugitive-gitlab.vim',
  'junegunn/gv.vim',
  'whiteinge/diffconflicts',
  'sindrets/diffview.nvim',
  'rhysd/committia.vim',
  'hotwatermorning/auto-git-diff',
  {
    'ThePrimeagen/git-worktree.nvim',
    config = function()
      local worktree = require('git-worktree')
      worktree.setup({
        clear_jumps_on_change = false,
        update_on_change = false,
      })
      worktree.on_tree_change(function(op, metadata)
        if op == worktree.Operations.Switch then
          vim.api.nvim_command('RestoreSession')
        end
      end)
    end,
  },
}
