return {
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  vim.keymap.set("n", "C-h", ":TmuxNacigateLeft<CR>", { desc = "move to left pane" }),
  vim.keymap.set("n", "C-j", ":TmuxNacigateDown<CR>", { desc = "move to below pane" }),
  vim.keymap.set("n", "C-k", ":TmuxNacigateUp<CR>", { desc = "move to above pane" }),
  vim.keymap.set("n", "C-l", ":TmuxNacigateRight<CR>", { desc = "move to right pane" }),
}
