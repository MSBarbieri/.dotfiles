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
  { "beauwilliams/focus.nvim", config =
  function()
    require("focus").setup()
  end
  },
  { 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } },
  { 'chrisbra/unicode.vim' },
  { 'nvim-telescope/telescope-symbols.nvim' },
}
