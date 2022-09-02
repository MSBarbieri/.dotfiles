lvim.log.level = "warn"
lvim.format_on_save = true
lvim.lsp.automatic_servers_installation = true
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

vim.cmd [[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]] -- h/t https://jeffkreeftmeijer.com/vim-number/

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

vim.cmd [[
au VimEnter * highlight Folded guibg=NONE
]]
