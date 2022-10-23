local dap = require('dap')

-- global lua function that when run, presents you choices of which config to run and then asks for arguments.

function _G.dapRunConfigWithArgs()
  local dap = require('dap')
  local ft = vim.bo.filetype
  if ft == "" then
      print("Filetype option is required to determine which dap configs are available")
      return
  end
  local configs = dap.configurations[ft]
  if configs == nil then
      print("Filetype \"" .. ft .. "\" has no dap configs")
      return
  end
  local mConfig = nil
  vim.ui.select(
      configs,
      {
          prompt = "Select config to run: ",
          format_item = function(config)
              return config.name
          end
      },
      function(config)
          mConfig = config
      end
  )

  -- redraw to make ui selector disappear
  vim.api.nvim_command("redraw")

  if mConfig == nil then
      return
  end
  vim.ui.input(
      {
          prompt = mConfig.name .." - with args: ",
      },
      function(input)
          if input == nil then
              return
          end
          local args = vim.split(input, ' ', true)
          mConfig.args = args
          dap.run(mConfig)
      end
  )
end

local function attachToNode()
  print("attaching to node process")
  dap.run({
    type = 'node2',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
  })
end

local function attachToChrome()
  print("attaching to Chrome process")
  dap.run({
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}"
  })
end

local function debugJest(testName, fileName)
  print("starting " .. testName .. " with file " .. fileName)
  dap.run({
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = {'--inspect-brk', '${workspaceFolder}/node_modules/.bin/jest', '--no-coverage', '-t', string.format("%s", testName), '--', fileName},
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
    console = 'integratedTerminal',
    port = 9229,
  })
end

local function attachToRemote()
  print("attaching")
  dap.run({
      type = 'node2',
      request = 'attach',
      address = "127.0.0.1",
      port = 9229,
      localRoot = vim.fn.getcwd(),
      remoteRoot = "/home/vcap/app",
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = {'<node_internals>/**/*.js'},
    })
end

return {
  debugJest = debugJest,
  attachToNode = attachToNode,
  attachToChrome = attachToChrome,
  attachToRemote = attachToRemote,
}

-- taken from https://www.reddit.com/r/neovim/comments/y7dvva/comment/iswqdz7/?context=3
--
---- setup adapters
--require('dap-vscode-js').setup({
--    debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
--    debugger_cmd = { 'js-debug-adapter' },
--    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
--})

--local dap = require('dap')

---- custom adapter for running tasks before starting debug
--local custom_adapter = 'pwa-node-custom'
--dap.adapters[custom_adapter] = function(cb, config)
--    if config.preLaunchTask then
--        local async = require('plenary.async')
--        local notify = require('notify').async

--        async.run(function()
--            ---@diagnostic disable-next-line: missing-parameter
--            notify('Running [' .. config.preLaunchTask .. ']').events.close()
--        end, function()
--            vim.fn.system(config.preLaunchTask)
--            config.type = 'pwa-node'
--            dap.run(config)
--        end)
--    end
--end

---- language config
--for _, language in ipairs({ 'typescript', 'javascript' }) do
--    dap.configurations[language] = {
--        {
--            name = 'Launch',
--            type = 'pwa-node',
--            request = 'launch',
--            program = '${file}',
--            rootPath = '${workspaceFolder}',
--            cwd = '${workspaceFolder}',
--            sourceMaps = true,
--            skipFiles = { '<node_internals>/**' },
--            protocol = 'inspector',
--            console = 'integratedTerminal',
--        },
--        {
--            name = 'Attach to node process',
--            type = 'pwa-node',
--            request = 'attach',
--            rootPath = '${workspaceFolder}',
--            processId = require('dap.utils').pick_process,
--        },
--        {
--            name = 'Debug Main Process (Electron)',
--            type = 'pwa-node',
--            request = 'launch',
--            program = '${workspaceFolder}/node_modules/.bin/electron',
--            args = {
--                '${workspaceFolder}/dist/index.js',
--            },
--            outFiles = {
--                '${workspaceFolder}/dist/*.js',
--            },
--            resolveSourceMapLocations = {
--                '${workspaceFolder}/dist/**/*.js',
--                '${workspaceFolder}/dist/*.js',
--            },
--            rootPath = '${workspaceFolder}',
--            cwd = '${workspaceFolder}',
--            sourceMaps = true,
--            skipFiles = { '<node_internals>/**' },
--            protocol = 'inspector',
--            console = 'integratedTerminal',
--        },
--        {
--            name = 'Compile & Debug Main Process (Electron)',
--            type = custom_adapter,
--            request = 'launch',
--            preLaunchTask = 'npm run build-ts',
--            program = '${workspaceFolder}/node_modules/.bin/electron',
--            args = {
--                '${workspaceFolder}/dist/index.js',
--            },
--            outFiles = {
--                '${workspaceFolder}/dist/*.js',
--            },
--            resolveSourceMapLocations = {
--                '${workspaceFolder}/dist/**/*.js',
--                '${workspaceFolder}/dist/*.js',
--            },
--            rootPath = '${workspaceFolder}',
--            cwd = '${workspaceFolder}',
--            sourceMaps = true,
--            skipFiles = { '<node_internals>/**' },
--            protocol = 'inspector',
--            console = 'integratedTerminal',
--        },
--    }
--end
