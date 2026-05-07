local map = vim.keymap.set

return {
  {
    'neoclide/coc.nvim',
    branch = 'master',
    build = 'npm ci',
    config = function()
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

      -- Completion navigation
      map('i', '<C-j>', function()
        return vim.fn['coc#pum#visible']() == 1 and vim.fn['coc#pum#next'](1) or '<Tab>'
      end, { expr = true })
      map('i', '<C-k>', function()
        return vim.fn['coc#pum#visible']() == 1 and vim.fn['coc#pum#prev'](1) or '<S-Tab>'
      end, { expr = true })

      -- Snippet navigation
      vim.g.coc_snippet_next = '<Tab>'
      vim.g.coc_snippet_prev = '<S-Tab>'

      -- Trigger completion
      map('i', '<C-space>', 'coc#refresh()', { silent = true, expr = true })

      -- Confirm completion
      map('i', '<CR>', function()
        if vim.fn['coc#pum#visible']() == 1 then
          return vim.fn['coc#pum#confirm']()
        end
        return '<C-g>u<CR><C-r>=coc#on_enter()<CR>'
      end, { expr = true, silent = true })

      -- Diagnostic navigation
      map('n', '[d', '<Plug>(coc-diagnostic-prev)', { silent = true })
      map('n', ']d', '<Plug>(coc-diagnostic-next)', { silent = true })
      map('n', '[D', '<Plug>(coc-diagnostic-prev-error)', { silent = true })
      map('n', ']D', '<Plug>(coc-diagnostic-next-error)', { silent = true })

      -- Git navigation
      map('n', '[c', '<Plug>(coc-git-prevchunk)')
      map('n', ']c', '<Plug>(coc-git-nextchunk)')
      map('n', '[g', '<Plug>(coc-git-prevconflict)')
      map('n', ']g', '<Plug>(coc-git-nextconflict)')

      -- Git operations
      map('n', '<space>ghs', '<cmd>CocCommand git.chunkStage<cr>', { silent = true })
      map('n', '<space>ghu', '<cmd>CocCommand git.chunkUnstage<cr>', { silent = true })
      map('n', '<space>gu', '<cmd>CocCommand git.chunkUndo<cr>', { silent = true })
      map('v', '<space>gu', '<cmd>CocCommand git.chunkUndo<cr>', { silent = true })
      map('n', '<space>gb', '<cmd>CocCommand git.showBlameDoc<cr>', { silent = true })
      map('n', '<space>gi', '<Plug>(coc-git-chunkinfo)', { silent = true })
      map('o', 'ig', '<Plug>(coc-git-chunk-inner)', { silent = true })
      map('x', 'ig', '<Plug>(coc-git-chunk-inner)', { silent = true })

      -- LSP
      map('n', 'gd', '<Plug>(coc-definition)', { silent = true })
      map('n', 'gD', '<Plug>(coc-declaration)', { silent = true })
      map('n', 'gr', '<Plug>(coc-references)', { silent = true })
      map('n', 'gu', '<Plug>(coc-references-used)', { silent = true })
      map('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
      map('n', 'gm', '<Plug>(coc-implementation)', { silent = true })

      -- Rename/refactor
      map('n', '<space>cn', '<Plug>(coc-rename)')
      map('n', '<space>cb', '<Plug>(coc-refactor)')
      map('n', '<space>re', '<Plug>(coc-codeaction-refactor)', { silent = true })
      map('x', '<space>rs', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })
      map('n', '<space>rs', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })

      -- Code actions
      map('n', '<space>cf', '<Plug>(coc-fix-current)')
      map('n', '<space>ce', '<Plug>(coc-codelens-action)')
      map('n', '<space>cc', '<Plug>(coc-codeaction-cursor)')
      map('n', '<space>cS', '<Plug>(coc-codeaction-source)')
      map('n', '<space>cl', '<Plug>(coc-codeaction-line)')
      map('v', '<space>cs', '<Plug>(coc-codeaction-selected)')
      map('n', '<space>cs', '<Plug>(coc-codeaction-selected)')

      -- Outline and misc
      map('n', '<space>co', '<Cmd>CocOutline<cr>')
      map('n', '<space>cr', '<Cmd>CocRestart<CR>')

      -- User commands
      vim.api.nvim_create_user_command('TscGTSD', function() vim.fn.CocAction('runCommand', 'tsserver.goToSourceDefinition') end, {})
      vim.api.nvim_create_user_command('Tsc', function() vim.fn.CocAction('runCommand', 'tsserver.watchBuild') end, {})
      vim.api.nvim_create_user_command('Prettier', ':CocCommand prettier.formatFile', {})
      vim.api.nvim_create_user_command('Format', function() vim.fn.CocActionAsync('format') end, {})
      vim.api.nvim_create_user_command('Fold', function(opts) vim.fn.CocAction('fold', opts.args) end, { nargs = '?' })
      vim.api.nvim_create_user_command('OR', function() vim.fn.CocActionAsync('runCommand', 'editor.action.organizeImport') end, {})
      vim.api.nvim_create_user_command('CHI', function() vim.fn.CocActionAsync('runCommand', 'document.showIncomingCalls') end, {})
      vim.api.nvim_create_user_command('CHO', function() vim.fn.CocActionAsync('runCommand', 'document.showOutgoingCalls') end, {})

      -- Call hierarchy
      map('n', '<space>cki', '<Cmd>CHI<cr>')
      map('n', '<space>cko', '<Cmd>CHO<cr>')

      -- Scroll float
      map('n', '<C-f>', function() return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](1) or '<C-f>' end, { silent = true, nowait = true, expr = true })
      map('n', '<C-b>', function() return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](0) or '<C-b>' end, { silent = true, nowait = true, expr = true })
      map('i', '<C-f>', function() return vim.fn['coc#float#has_scroll']() == 1 and '<C-r>=coc#float#scroll(1)<CR>' or '<Right>' end, { silent = true, nowait = true, expr = true })
      map('i', '<C-b>', function() return vim.fn['coc#float#has_scroll']() == 1 and '<C-r>=coc#float#scroll(0)<CR>' or '<Left>' end, { silent = true, nowait = true, expr = true })
      map('v', '<C-f>', function() return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](1) or '<C-f>' end, { silent = true, nowait = true, expr = true })
      map('v', '<C-b>', function() return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](0) or '<C-b>' end, { silent = true, nowait = true, expr = true })

      -- K for documentation
      map('n', 'K', ':call v:lua.ShowDocumentation()<CR>', { silent = true })

      -- Transparent cursor fix
      vim.g.coc_disable_transparent_cursor = 1

      -- CocNext/CocPrev
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

      -- Autocmds
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

      -- Highlights
      vim.api.nvim_set_hl(0, 'CocHighlightText', { link = 'TabLineSel', default = true })
      vim.api.nvim_set_hl(0, 'CocCodeLens', { link = 'LspCodeLens', default = true })
      vim.api.nvim_set_hl(0, 'CocPumSearch', { link = 'Statement', default = true })
    end,
  },
  'antoinemadec/coc-fzf',
}
