-- auto commit on save file
lvim.autocommands = {
  {
    "BufWritePost",
    {
      pattern = { "*" },
      command = "silent !git add -A &> /dev/null; git commit -m \"$(date)\" &> /dev/null"
    }
  }
}


-- create new branch on save and move worktree if exists
local worktree_command = vim.cmd("!git worktree list | awk 'NR==1 {$2}'")
vim.pretty_print(worktree_command)
