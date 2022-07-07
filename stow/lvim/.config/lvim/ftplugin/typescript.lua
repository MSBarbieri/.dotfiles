local dap = require('dap')

dap.configurations.typescript = {
  {
    name = 'Launch node',
    type = 'node2',
    request = 'launch',
    skipFiles = { "<node_internals>/**" },
    program = '${workspaceFolder}/dist/index.js',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    outFiles = { "${workspaceFolder}/**/*.js" }
  }
}
