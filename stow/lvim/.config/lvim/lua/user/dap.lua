-- dap config
---------------------------------------------------------------------------------------------
local dap = require('dap')

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return os.getenv("HOME") .. '/.pyenv/shims/python3'
    end
  },
}

dap.adapters.python = {
  type = 'executable';
  command = os.getenv("HOME") .. '/.pyenv/shims/python3';
  args = { '-m', 'debugpy.adapter' }; -- or { '-m', 'debugpy.adapter' }
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
