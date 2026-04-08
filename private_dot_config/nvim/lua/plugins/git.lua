local map = vim.keymap.set

return {
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    config = function()
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

      -- Git status in new tab
      map('n', '<leader>gs', ':tab Git<cr>:G<cr>/^M\\s<cr>:let @/=""<cr>', { silent = true })

      -- Fugitive blame extension
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

      -- Put changed file names from previous commit into quickfix
      vim.api.nvim_create_user_command('Gshow', function(opts)
        vim.fn.setqflist(vim.tbl_map(function(f)
          return { filename = f, lnum = 1 }
        end, vim.fn.systemlist("git show --pretty='' --name-only " .. (opts.args or ''))))
      end, { nargs = '?', bar = true })
    end,
  },
  'tpope/vim-rhubarb',
  {
    'shumphrey/fugitive-gitlab.vim',
    init = function()
      vim.g.fugitive_gitlab_domains = { 'https://git.lab.smartsheet.com' }
    end,
  },
  'junegunn/gv.vim',
  {
    'whiteinge/diffconflicts',
    keys = {
      { '<leader>dcc', ':DiffConflicts<cr>', silent = true },
      { '<leader>dch', ':DiffConflictsShowHistory<cr>', silent = true },
      { '<leader>dcb', ':DiffConflictsWithHistory<cr>', silent = true },
      { '<leader>dcu', ':diffupdate<cr>', silent = true },
      { '<leader>dcs', ':cq<cr>', silent = true },
    },
  },
  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>dvm', '<Cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>' },
      { '<leader>dvp', '<Cmd>DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges<cr>' },
      { '<leader>dvo', '<cmd>DiffviewOpen<cr>' },
      { '<leader>dvf', '<Cmd>DiffviewFileHistory %<cr>' },
      { '<leader>dvF', '<Cmd>DiffviewFileHistory<cr>' },
      { '<leader>dvl', '<Cmd>DiffviewOpen HEAD~1<cr>' },
      { '<leader>dvh', '<Cmd>DiffviewFileHistory --range=origin/HEAD..HEAD<cr>' },
      { '<leader>dvh', "<Cmd>'<,'>DiffviewFileHistory<CR>", mode = 'v' },
    },
  },
  {
    'rhysd/committia.vim',
    init = function()
      vim.g.committia_open_only_vim_starting = 1

      -- committia's regex only matches .git/worktrees/*, not .bare/worktrees/*
      -- Set GIT_DIR and GIT_WORK_TREE before committia runs so it skips the regex
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
    end,
  },
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
