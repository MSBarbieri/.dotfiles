-- generic LSP settings
-- Additional Plugins
lvim.plugins = {
  { "shaunsingh/nord.nvim" },
  { "ThePrimeagen/git-worktree.nvim" },
  { "ThePrimeagen/harpoon" },
  { "danilamihailov/beacon.nvim" },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "wellle/context.vim" },
  { "dbeniamine/cheat.sh-vim" },
  -- { "rcarriga/nvim-dap-ui" },
  { "beauwilliams/focus.nvim", config =
  function()
    require("focus").setup()
  end
  },
  { 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } },
  { 'chrisbra/unicode.vim' },
  { 'nvim-telescope/telescope-symbols.nvim' },
}
