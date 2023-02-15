-- require("neodev").setup({
--   library = { plugins = { "nvim-dap-ui" }, types = true },
-- })
-- Plug 'mfussenegger/nvim-dap'
local dap = require('dap')
-- dap.set_log_level('TRACE')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/code/vscode-node-debug2/out/src/nodeDebug.js'},
}

-- note: chrome has to be started with a remote debugging port: --remote-debugging-port=9222
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = {os.getenv("HOME") .. "/code/vscode-chrome-debug/out/src/chromeDebug.js"}
}

vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🟢', texthl='', linehl='', numhl=''})

require("nvim-dap-virtual-text").setup()
vim.g.dap_virtual_text = true

-- dap-ui
require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.40 },
        { id = "breakpoints", size = 0.05 },
        { id = "stacks", size = 0.40 },
        -- "watches",
      },
      size = 50,
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
        { id = "watches", size = 0.25 },
      },
      size = 10,
      position = "bottom",
    },
  },
  controls = {
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
  },
  floating = {
    border = "rounded",
    max_height = nil,
    max_width = nil,
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  render = {
    indent = 1,
    max_type_length = nil,
  }
})

-- use nvim-dap events to open and close the windows automatically
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- nvim-telescope/telescope-dap.nvim
-- map('n', '<leader>ds', '<cmd>lua require'telescope'.extensions.dap.frames{}<CR>')
-- map('n', '<leader>dc', '<cmd>lua require'telescope'.extensions.dap.commands{}<CR>')
-- map('n', '<leader>db', '<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>')

require("jester").setup({
  cmd = "yarn jest --no-watchman -t '$result' -- $file yarn test:local", -- run command
  identifiers = {"test", "it"}, -- used to identify tests
  prepend = {"describe"}, -- prepend describe blocks
  expressions = {"call_expression"}, -- tree-sitter object used to scan for tests/describe blocks
  path_to_jest_run = 'yarn jest', -- used to run tests
  path_to_jest_debug = './node_modules/bin/jest', -- used for debugging
  terminal_cmd = ":vsplit | terminal", -- used to spawn a terminal for running tests, for debugging refer to nvim-dap's config
  dap = { -- debug adapter configuration
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = {'--inspect-brk', '$path_to_jest', '--no-coverage', '-t', '$result', '--', '$file'},
    args = { '--no-cache' },
    sourceMaps = 'inline',
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
    console = 'integratedTerminal',
    port = 9229,
    disableOptimisticBPs = true
  }
})

vim.cmd [[
  " vim-test
  " let test#strategy = 'toggleterm'
  let test#strategy = 'vimux'
  nmap <silent> <leader>tt :TestNearest<CR>
  nmap <silent> <leader>tf :TestFile<CR>
  nmap <silent> <leader>tl :TestLast<CR>
  nmap <silent> <leader>tv :TestVisit<CR>
  " nmap <silent> <leader>ts :TestSuite<CR>

  " let test#typescriptreact#jest#options = {
  "   \ 'nearest': '--backtrace',
  "   \ 'file':    '--format documentation',
  "   \ 'suite':   '--tag ~slow',
  " \}

  " dap-ui
  nnoremap <leader>dq  :lua require'dapui'.toggle()<CR>
  nnoremap <leader>due :lua require'dapui'.eval()<cr>
  vnoremap <leader>due :lua require'dapui'.eval()<cr>
  nnoremap <leader>duf :lua require'dapui'.float_element()<cr>
  nnoremap <leader>dus :lua require'dapui'.float_element("scopes")<cr>
  nnoremap <leader>dur :lua require'dapui'.float_element("repl")<cr>

  " dap node
  nnoremap <leader>dan :lua require'debugHelper'.attachToNode()<CR>
  nnoremap <leader>dar :lua require'debugHelper'.attachToRemote()<CR>
  nnoremap <leader>dac :lua require'debugHelper'.attachToChrome()<CR>

  " nvim-dap
  nnoremap <leader>dt  :lua require'dap'.toggle_breakpoint()<CR>
  nnoremap <leader>dn  :lua require'dap'.continue()<CR>
  nnoremap <leader>d_  :lua require'dap'.disconnect();require"dap".close();require"dap".run_last()<CR>

  nnoremap <leader>dbc :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
  nnoremap <leader>dbx :lua require'dap'.clear_breakpoints()<CR>
  nnoremap <leader>dbm :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
  nnoremap <leader>dso :lua require'dap'.step_out()<CR>
  nnoremap <leader>dsi :lua require'dap'.step_into()<CR>
  nnoremap <leader>dsv :lua require'dap'.step_over()<CR>
  nnoremap <leader>dk  :lua require'dap'.up()<CR>
  nnoremap <leader>dj  :lua require'dap'.down()<CR>
  nnoremap <leader>drv :lua require'dap'.repl.open({}, 'vsplit')<CR>
  nnoremap <leader>dro :lua require'dap'.repl.open()<CR>
  nnoremap <leader>drl :lua require'dap'.repl.run_last()<CR>
  nnoremap <leader>di  :lua require'dap.ui.widgets'.hover()<CR>
  vnoremap <leader>di  :lua require'dap.ui.variables'.visual_hover()<CR>
  nnoremap <leader>dI  :lua require'dap.ui.widgets'.hover()<CR>
  nnoremap <leader>d?  :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
  nnoremap <leader>de  :lua require'dap'.set_exception_breakpoints({"all"})<CR>
]]
