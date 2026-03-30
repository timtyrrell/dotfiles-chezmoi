return {
  {
    'junegunn/fzf.vim',
    dependencies = {
      { dir = '/opt/homebrew/opt/fzf' },
    },
    config = function()
      -- Rg commands (vimscript required for fzf#vim functions)
      local rg_colors = ' --colors line:fg:red --colors path:fg:blue --colors match:fg:green '

      vim.cmd([[
        command! -bang -nargs=* Rg
        \   call fzf#vim#grep(
        \       'rg' . ']] .. rg_colors .. [[' . ' --line-number --color=always --smart-case -- '.shellescape(<q-args>), 1,
        \       fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}), <bang>0
        \   )

        command! -bang -nargs=* RgLines
        \   call fzf#vim#grep(
        \       'rg --column --line-number --no-heading --color=always --case-sensitive -- '.shellescape(<q-args>), 1,
        \       fzf#vim#with_preview({ 'options': ['--delimiter', ':', '--nth', '4..'] }), <bang>0)

        command! -bang -nargs=* HistoryCmds call fzf#vim#command_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))
        command! -bang -nargs=* HistorySearch call fzf#vim#search_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))

        " Ag PATTERN DIR
        command! -bang -nargs=+ -complete=dir AgDir call fzf#vim#ag_raw(<q-args>, <bang>0)
        command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
        command! -bang -nargs=* AgWord call fzf#vim#ag(<q-args>, '--word-regexp', <bang>0)
      ]])

      -- RgReloader: On-demand search using Rg if query is non-empty
      local rg_full_command = "%s" .. rg_colors .. " --line-number --color=always --smart-case --fixed-strings -- {q} || true"
      local rg_initial_command = 'true'

      local function rg_reloader(query, fullscreen, rg_base_command)
        vim.cmd(':wincmd l')
        local rg_reload_command = string.format(rg_full_command, rg_base_command)
        local fzf_options = {
          options = {
            '--prompt', 'λ ',
            '--disabled',
            '--phony',
            '--query', query,
            '--preview-window', 'right,50%,border-left',
            '--bind', 'change:reload:' .. rg_reload_command,
            '--bind', '\\:toggle-preview',
          },
        }
        vim.fn['fzf#vim#grep'](rg_initial_command, 1, vim.fn['fzf#vim#with_preview'](fzf_options))
      end

      -- RgLoader: On-load search using Rg and Fzf
      local function rg_loader(query, fullscreen, rg_base_command)
        vim.cmd(':wincmd l')
        local rg_load_fmt = rg_base_command .. rg_colors .. ' --line-number --color=always --smart-case --fixed-strings %s || true'
        local rg_load_command = string.format(rg_load_fmt, vim.fn.shellescape(query))
        local fzf_options = {
          options = {
            '--prompt', 'λ ',
            '--exact',
            '--preview-window', 'right,50%,border-left',
            '--bind', '\\:toggle-preview',
          },
        }
        vim.fn['fzf#vim#grep'](rg_load_command, 1, vim.fn['fzf#vim#with_preview'](fzf_options))
      end

      -- Search all file content
      local rg_all = 'rg'
      vim.api.nvim_create_user_command('RgAll', function(opts)
        rg_reloader(opts.args, opts.bang, rg_all)
      end, { nargs = '*', bang = true })
      vim.keymap.set('n', '<Leader>raa', ':RgAll<CR>')
      vim.keymap.set('n', '<Leader>raf', ':RgAll<CR>')
      vim.keymap.set('n', '<Leader>rawa', function() rg_loader(vim.fn.expand('<cword>'), false, rg_all) end, { silent = true })

      -- JS/TS searches
      local rg_js_ts_all = 'rg --type webjsts'
      vim.api.nvim_create_user_command('RgJsTsAll', function(opts) rg_reloader(opts.args, opts.bang, rg_js_ts_all) end, { nargs = '*', bang = true })
      vim.keymap.set('n', '<Leader>rat', ':RgJsTsAll<CR>')
      vim.keymap.set('n', '<Leader>rawt', function() rg_loader(vim.fn.expand('<cword>'), false, rg_js_ts_all) end, { silent = true })

      local rg_js_ts = 'rg --type webjsts --glob "!**/{__tests__,__mocks__,__tests_scaffolding__}/**/*.*" '
      vim.api.nvim_create_user_command('RgJsTs', function(opts) rg_reloader(opts.args, opts.bang, rg_js_ts) end, { nargs = '*', bang = true })
      vim.keymap.set('n', '<Leader>rft', ':RgJsTs<CR>')
      vim.keymap.set('n', '<Leader>rfwt', function() rg_loader(vim.fn.expand('<cword>'), false, rg_js_ts) end, { silent = true })

      local rg_js_ts_test = 'rg --type webjsts --glob "**/{__tests__,__mocks__,__tests_scaffolding__}/**/*.*"'
      vim.api.nvim_create_user_command('RgJsTsTest', function(opts) rg_reloader(opts.args, opts.bang, rg_js_ts_test) end, { nargs = '*', bang = true })
      vim.keymap.set('n', '<Leader>rtt', ':RgJsTsTest<CR>')
      vim.keymap.set('n', '<Leader>rtwt', function() rg_loader(vim.fn.expand('<cword>'), false, rg_js_ts_test) end, { silent = true })

      -- Ruby searches
      local rg_rb_all = 'rg --type webrb'
      vim.api.nvim_create_user_command('RgRbAll', function(opts) rg_reloader(opts.args, opts.bang, rg_rb_all) end, { nargs = '*', bang = true })
      vim.keymap.set('n', '<Leader>rar', ':RgRbAll<CR>')
      vim.keymap.set('n', '<Leader>rawr', function() rg_loader(vim.fn.expand('<cword>'), false, rg_rb_all) end, { silent = true })

      local rg_rb = 'rg --type webrb --glob "!spec/**/*.*"'
      vim.api.nvim_create_user_command('RgRb', function(opts) rg_reloader(opts.args, opts.bang, rg_rb) end, { nargs = '*', bang = true })
      vim.keymap.set('n', '<Leader>rfr', ':RgRb<CR>')
      vim.keymap.set('n', '<Leader>rfwr', function() rg_loader(vim.fn.expand('<cword>'), false, rg_rb) end, { silent = true })

      local rg_rb_test = 'rg --type webrb --glob "spec/**/*.*"'
      vim.api.nvim_create_user_command('RgRbTest', function(opts) rg_reloader(opts.args, opts.bang, rg_rb_test) end, { nargs = '*', bang = true })
      vim.keymap.set('n', '<Leader>rtr', ':RgRbTest<CR>')
      vim.keymap.set('n', '<Leader>rtwr', function() rg_loader(vim.fn.expand('<cword>'), false, rg_rb_test) end, { silent = true })

      -- Java searches
      local rg_java_all = 'rg --type java --type kotlin'
      vim.api.nvim_create_user_command('RgJavaAll', function(opts) rg_reloader(opts.args, opts.bang, rg_java_all) end, { nargs = '*', bang = true })
      vim.keymap.set('n', '<Leader>raj', ':RgJavaAll<CR>')
      vim.keymap.set('n', '<Leader>rawj', function() rg_loader(vim.fn.expand('<cword>'), false, rg_java_all) end, { silent = true })

      local rg_java = 'rg --type java --type kotlin --glob "!**/test/**/*.*" '
      vim.api.nvim_create_user_command('RgJava', function(opts) rg_reloader(opts.args, opts.bang, rg_java) end, { nargs = '*', bang = true })
      vim.keymap.set('n', '<Leader>rfj', ':RgJava<CR>')
      vim.keymap.set('n', '<Leader>rfwj', function() rg_loader(vim.fn.expand('<cword>'), false, rg_java) end, { silent = true })

      local rg_java_test = 'rg --type java --type kotlin --glob "**/test/**/*.*"'
      vim.api.nvim_create_user_command('RgJavaTest', function(opts) rg_reloader(opts.args, opts.bang, rg_java_test) end, { nargs = '*', bang = true })
      vim.keymap.set('n', '<Leader>rtj', ':RgJavaTest<CR>')
      vim.keymap.set('n', '<Leader>rtwj', function() rg_loader(vim.fn.expand('<cword>'), false, rg_java_test) end, { silent = true })

      -- RGdir: filter search by dir with exact match
      vim.cmd([[
        function! RipgrepFzfExact(filepaths, fullscreen)
          let command_fmt = 'rg --column --line-number --no-heading --color=always --case-sensitive --with-filename -e ''%s'' ' . a:filepaths . ' || true'
          let initial_command = printf(command_fmt, '')
          let reload_command = printf(command_fmt, '{q}')
          let spec = {'options': ['--disabled', '--bind', 'change:reload:'.reload_command]}
          call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
        endfunction
        command! -nargs=* -bang -complete=dir RGdir call RipgrepFzfExact(<q-args>, <bang>0)
      ]])

      -- FZFCd: change to git project directory
      vim.cmd([[
        command! -bang -bar -nargs=? -complete=dir FZFCd
          \ call fzf#run(fzf#wrap(
          \ {'source': 'find '..( empty("<args>") ? ( <bang>0 ? "~" : "." ) : "<args>" ) ..
          \ ' -type d -maxdepth 1', 'sink': 'cd'}))
      ]])
      vim.keymap.set('n', '<Leader>fI', ':FZFCd ~/code<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>fi', ':FZFCd!<CR>', { silent = true })

      -- BD: FZF Buffer Delete
      vim.cmd([[
        function! s:list_buffers()
          redir => list
          silent ls
          redir END
          return split(list, "\n")
        endfunction

        function! s:delete_buffers(lines)
          execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
        endfunction

        command! BD call fzf#run(fzf#wrap({
          \ 'source': s:list_buffers(),
          \ 'sink*': { lines -> s:delete_buffers(lines) },
          \ 'options': '--no-preview --multi --reverse --bind ctrl-s:select-all+accept'
          \ }))

        command! -bang Args call fzf#run(fzf#wrap('args',
          \ {'source': map([argidx()]+(argidx()==0?[]:range(argc())[0:argidx()-1])+range(argc())[argidx()+1:], 'argv(v:val)')}, <bang>0))
      ]])

      -- FzfFallback: switch from fzf search to file search
      vim.cmd([[
        function! s:FzfFallback()
          if &filetype != 'FZF'
            return
          endif
          let query = getline('.')[stridx(getline('.'), ' ') : col('.') - 1]
          echo query
          close
          sleep 1m
          call fzf#vim#files('.', {'options': ['-q', query]})
        endfunction
        tnoremap <c-space> <c-\><c-n>c:call <sid>FzfFallback()<cr>
      ]])

      -- Fzf complete path without extension
      vim.cmd([[
        function! s:remove_file_extension(path)
          return substitute(join(a:path), '\.[tj]sx\=$', "", "")
        endfunction
        function! AbsolutePathNoExtension()
          return fzf#vim#complete#path(
                \ "fd -t f",
                \ fzf#wrap({ 'reducer': function('s:remove_file_extension')})
                \ )
        endfunction
        inoremap <expr> <c-x><c-f> AbsolutePathNoExtension()
      ]])
    end,
  },
}
