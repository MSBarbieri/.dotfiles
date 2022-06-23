local dap_install = require("dap-install")
dap_install.config("jsnode", {
  configurations = {
    type = "node-terminal",
    request = "launch",
    name = "Launch Program",
    program = '${file}'
  }
})
