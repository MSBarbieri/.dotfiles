-- dap config
---------------------------------------------------------------------------------------------
local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/dev/dap/vscode-node-debug2/out/src/nodeDebug.js' },
}

-- dap.adapters.coreclr = {
--   type = 'executable',
--   command = os.getenv('HOME') .. '/dev/dap/netcoredbg/netcoredbg',
--   args = { '--interpreter=vscode' }
-- }

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/dev/dap/vscode-chrome-debug/out/src/chromeDebug.js" } -- TODO adjust
}
-- daput
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
