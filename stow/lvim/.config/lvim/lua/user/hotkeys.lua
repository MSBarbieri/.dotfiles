lvim.keys.normal_mode["<Space>-"] = ":split<cr>"
lvim.keys.normal_mode["<Space>_"] = ":vsplit<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.which_key.mappings["gt"] = { ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
  "Worktree list" }
lvim.builtin.which_key.mappings["ga"] = { ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
  "Worktree add" }
lvim.builtin.which_key.mappings["da"] = { ":lua require('dapui').toggle()<CR>", "toggle dapui" }
lvim.builtin.which_key.mappings["un"] = { ":lua require'telescope.builtin'.symbols{ sources = {'emoji', 'math' } }<CR>",
  "Unicode" }
