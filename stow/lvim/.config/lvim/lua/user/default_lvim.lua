lvim.log.level = "warn"
lvim.format_on_save = true
lvim.lsp.installer.automatic_installation = true
lvim.builtin.lualine.style = "lvim"
lvim.builtin.dap.active = true
lvim.transparent_window = true
lvim.leader = "space"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

-- colorscheme
vim.g.tokyonight_style = "storm"
lvim.colorscheme = "tokyonight"
lvim.builtin.lualine.options.theme = "tokyonight"
lvim.builtin.lualine.style = "lvim"
lvim.builtin.gitsigns.opts.numhl = true
lvim.builtin.gitsigns.opts.current_line_blame = true
vim.wo.colorcolumn = "80,100"


if vim.fn.has "wsl" == 1 then
  vim.g.clipboard = {
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
  }
end
