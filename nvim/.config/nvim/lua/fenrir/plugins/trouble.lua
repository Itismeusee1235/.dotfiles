-- return {
--   "folke/trouble.nvim",
--   dependencies = {
--     "nvim-tree/nvim-web-devicons",
--     "folke/todo-comments.nvim",
--   },
--   keys = {
--     { "<leader>xx", ":TroubleToggle<CR>", { desc = "Open/Close trouble list" } },
--     { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Open trouble workspace diagnostics" } },
--     { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Open trouble document diagnostics" } },
--     { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Open trouble quickfix list" } },
--     { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", { desc = "Open trouble location list" } },
--     { "<leader>xt", "<cmd>TodoTrouble<CR>", { desc = "Open todos in trouble" } },
--   },
-- }

return {
  "folke/trouble.nvim",
  lazy = true, -- Load trouble plugin lazily
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  keys = {
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
  },
  config = function()
    require("trouble").setup({
      auto_open = false,
      auto_close = true,
      use_diagnostic_signs = true,
    })
  end,
}
