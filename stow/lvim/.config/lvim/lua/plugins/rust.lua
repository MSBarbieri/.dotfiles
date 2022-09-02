local M = {}

M.load_rust_tools = function()
  local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.7.4/'
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
  local lsp_installer_servers = require "nvim-lsp-installer.servers"
  local _, requested_server = lsp_installer_servers.get_server "rust_analyzer"

  require("rust-tools").setup({
    tools = {
      autoSetHints = true,
      hover_with_actions = true,
      runnables = {
        use_telescope = true,
      },
    },
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    server = {
      -- cmd = { vim.fn.stdpath "data" .. "/lsp_servers/rust/rust-analyzer" },
      cmd_env = requested_server._default_options.cmd_env,
      on_attach = require("lvim.lsp").common_on_attach,
      on_init = require("lvim.lsp").common_on_init,
    }
  })
end

return M
