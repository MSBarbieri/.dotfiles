--[[
lvim is the global options object
Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]

-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.lsp.automatic_servers_installation = true
-- lvim.builtin.lualine.style = "lvim"
lvim.builtin.dap.active = true
lvim.transparent_window = true
-- keymappings [view all the defaults by pressing <leader>Lk]
-- add your own keymapping
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.leader = "space"
lvim.keys.normal_mode["<Space>-"] = ":split<cr>"
lvim.keys.normal_mode["<Space>_"] = ":vsplit<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<Space>gt"] = ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>"
lvim.keys.normal_mode["<Space>ga"] = ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>"
lvim.keys.normal_mode["<Space>da"] = ":lua require('dapui').toggle()<CR>"
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
-- lvim.builtin.treesitter.ensure_installed = {
--   "bash",
--   "c",
--   "javascript",
--   "json",
--   "lua",
--   "python",
--   "typescript",
--   "tsx",
--   "css",
--   "rust",
--   "java",
--   "yaml",
--   "haskell"
-- }
-- lvim.builtin.treesitter.ensure_installed = "maintained"
-- lvim.builtin.treesitter.highlight.enabled = true

-- dap config
---------------------------------------------------------------------------------------------
local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/dev/dap/vscode-node-debug2/out/src/nodeDebug.js' },
}

dap.adapters.coreclr = {
  type = 'executable',
  command = os.getenv('HOME') .. '/dev/dap/netcoredbg/netcoredbg',
  args = { '--interpreter=vscode' }
}

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/dev/dap/vscode-chrome-debug/out/src/chromeDebug.js" } -- TODO adjust
}

dap.adapters.codelldb = function(on_adapter)
  -- This asks the system for a free port
  local tcp = vim.loop.new_tcp()
  tcp:bind('127.0.0.1', 0)
  local port = tcp:getsockname().port
  tcp:shutdown()
  tcp:close()

  -- Start codelldb with the port
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local opts = {
    stdio = { nil, stdout, stderr },
    args = { '--port', tostring(port) },
  }
  local handle
  local pid_or_err
  handle, pid_or_err = vim.loop.spawn(os.getenv("HOME") ..
    "/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/adapter/codelldb", opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
    end
  end)
  if not handle then
    vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
    stdout:close()
    stderr:close()
    return
  end
  vim.notify('codelldb started. pid=' .. pid_or_err)
  stderr:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
  local adapter = {
    type = 'server',
    host = '127.0.0.1',
    port = port
  }
  -- 💀
  -- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
  -- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
  vim.defer_fn(function() on_adapter(adapter) end, 500)
end

---------------------------------------------------------------------------------------------


-- generic LSP settings
-- Additional Plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  { "ThePrimeagen/git-worktree.nvim" },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "wellle/context.vim" },
  { "dbeniamine/cheat.sh-vim" },
  { "rcarriga/nvim-dap-ui" },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local dap_adapter = require('dap')
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
          adapter = dap_adapter.adapters.codelldb,
        },
        server = {
          -- cmd = { vim.fn.stdpath "data" .. "/lsp_servers/rust/rust-analyzer" },
          cmd_env = requested_server._default_options.cmd_env,
          on_attach = require("lvim.lsp").common_on_attach,
          on_init = require("lvim.lsp").common_on_init,
        }
      })
    end,
    ft = { "rust", "rs" },
  },
  { "beauwilliams/focus.nvim", config =
  function()
    require("focus").setup()
  end
  },
  { 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } }
}

-- integrating extensions
require("telescope").load_extension("git_worktree")
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

-- colorscheme
vim.g.tokyonight_style = "storm"
lvim.colorscheme = "tokyonight"
lvim.builtin.lualine.options.theme = "tokyonight"
lvim.builtin.lualine.style = "lvim"
lvim.builtin.gitsigns.opts.numhl = true
lvim.builtin.gitsigns.opts.current_line_blame = true
vim.wo.colorcolumn = "80,100"
