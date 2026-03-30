-- FzfSpell: spell suggest via fzf
local function fzf_spell_sink(word)
  vim.cmd('normal! "_ciw' .. word)
end

function _G.FzfSpell()
  local suggestions = vim.fn.spellsuggest(vim.fn.expand('<cword>'))
  return vim.fn['fzf#run']({
    source = suggestions,
    sink = fzf_spell_sink,
    options = '--preview-window hidden',
    down = 20,
  })
end

-- TabMessage: redirect command output to a new tab
function _G.TabMessage(cmd)
  local output = vim.fn.execute(cmd)
  if output == '' then
    vim.api.nvim_err_writeln('no output')
    return
  end
  vim.cmd('tabnew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  vim.bo.buflisted = false
  vim.bo.modified = false
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, '\n'))
end
vim.api.nvim_create_user_command('TabMessage', function(opts)
  _G.TabMessage(opts.args)
end, { nargs = '+', complete = 'command' })

-- Insert file path
function _G.InsertFilePath()
  vim.cmd("normal i" .. vim.fn.expand('%:p:h') .. '/')
end

-- CloseNoNameBuffers
function _G.CloseNoNameBuffers()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_name(bufnr) == '' then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
end

-- VimuxZoomInspectRunner
function _G.VimuxZoomInspectRunner()
  if vim.g.VimuxRunnerIndex then
    vim.fn.VimuxTmux('select-pane -t ' .. vim.g.VimuxRunnerIndex)
    vim.fn.VimuxTmux('resize-pane -Z -t ' .. vim.g.VimuxRunnerIndex)
    vim.fn.VimuxTmux('copy-mode')
  end
end

-- VimuxSlime: send visual selection to tmux
function _G.VimuxSlime()
  vim.fn.VimuxClearTerminalScreen()
  vim.fn.VimuxRunCommand(vim.fn.getreg('v'), 0)
  vim.fn.VimuxSendKeys('Enter')
end

-- UpdateRemotePlugins
function _G.UpdateRemotePlugins()
  vim.cmd('let &rtp=&rtp')
  vim.cmd('UpdateRemotePlugins')
end

-- FindAndReplace in all files
function _G.FindAndReplace(old, new)
  vim.cmd(string.format("args `rg --files-with-matches '%s' .`", old))
  vim.cmd(string.format("noautocmd argdo %%substitute/%s/%s/g | update", old, new))
end
vim.api.nvim_create_user_command('FindAndReplaceAll', function(opts)
  local args = vim.split(opts.args, '%s+')
  if #args ~= 2 then
    print('Need two arguments')
    return
  end
  _G.FindAndReplace(args[1], args[2])
end, { nargs = '+' })

-- Smart dd: use black hole register when deleting empty line
local function smart_dd()
  if vim.api.nvim_get_current_line():match('^%s*$') then
    return '"_dd'
  else
    return 'dd'
  end
end
vim.keymap.set('n', 'dd', smart_dd, { noremap = true, expr = true })

-- Smart d in visual mode: black hole register for empty lines
local function smart_d()
  local l = vim.api.nvim_win_get_cursor(0)[1]
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, l - 1, l, true)) do
    if line:match('^%s*$') then
      return '"_d'
    end
  end
  return 'd'
end
vim.keymap.set('v', 'd', smart_d, { noremap = true, expr = true })

-- PromptClaudeWithLocation
vim.api.nvim_create_user_command('PromptClaudeWithLocation', function()
  local file = vim.fn.expand('%:.')
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local annotated_file = '@' .. file

  vim.ui.input({ prompt = 'What should Claude do? ' }, function(user_input)
    if user_input == nil or user_input == '' then
      print('Aborted.')
      return
    end

    local message = string.format(
      '%s\n(For Lines %d–%d of the file %s.)',
      user_input, start_line, end_line, annotated_file
    )

    local pane = vim.fn.system("tmux list-panes -F '#{pane_id} #{pane_title}' | grep 'claude-pane' | awk '{print $1}'"):gsub('%s+', '')
    if pane == '' then
      print('Claude pane not found.')
      return
    end

    vim.g.VimuxRunnerType = 'pane'
    vim.g.VimuxRunnerPane = pane

    vim.fn['VimuxSendText'](message .. '\n')
    vim.fn.system('tmux select-pane -t ' .. pane)
  end)
end, { range = true })

-- Quickfix text format function
function _G.qftf(info)
  local items
  local ret = {}
  if info.quickfix == 1 then
    items = vim.fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 61
  local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
  local validFmt = '%s │%5d:%-3d│%s %s'
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ''
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = vim.fn.bufname(e.bufnr)
        if fname == '' then
          fname = '[No Name]'
        else
          fname = fname:gsub('^' .. vim.env.HOME, '~')
        end
        if #fname <= limit then
          fname = fnameFmt1:format(fname)
        else
          fname = fnameFmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
      str = validFmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end
vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

-- Coc diagnostic to quickfix
function _G.coc_qf_diagnostic()
  if not vim.g.coc_service_initialized or vim.g.coc_service_initialized == 0 then
    return
  end
  local diagnostic_list = vim.fn.CocAction('diagnosticList')
  local items = {}
  local loc_ranges = {}
  for _, d in ipairs(diagnostic_list) do
    local text = string.format('[%s%s] %s',
      (d.source == '' and 'coc.nvim' or d.source),
      (d.code and ' ' .. d.code or ''),
      vim.split(d.message, '\n')[1])
    table.insert(items, {
      filename = d.file,
      lnum = d.lnum,
      col = d.col,
      text = text,
      type = d.severity:sub(1, 1):upper(),
    })
    table.insert(loc_ranges, d.location.range)
  end
  vim.fn.setqflist({}, ' ', {
    title = 'CocDiagnosticList',
    items = items,
    context = { bqf = { lsp_ranges_hl = loc_ranges } },
  })
  vim.cmd('botright copen')
end

function _G.coc_qf_jump2loc(locs)
  local loc_ranges = {}
  for _, loc in ipairs(locs) do
    table.insert(loc_ranges, loc.range)
  end
  vim.fn.setloclist(0, {}, ' ', {
    title = 'CocLocationList',
    items = locs,
    context = { bqf = { lsp_ranges_hl = loc_ranges } },
  })
  local winid = vim.fn.getloclist(0, { winid = 0 }).winid
  if winid == 0 then
    vim.cmd('rightbelow lwindow')
  else
    vim.fn.win_gotoid(winid)
  end
end

-- ShowDocumentation for K mapping
function _G.ShowDocumentation()
  if vim.tbl_contains({ 'vim', 'help' }, vim.bo.filetype) then
    vim.cmd('h ' .. vim.fn.expand('<cword>'))
  elseif vim.fn.CocAction('hasProvider', 'hover') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.cmd('normal! K')
  end
end
