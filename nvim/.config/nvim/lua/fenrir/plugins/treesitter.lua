return{
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile"},
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },

  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = { enable = true, },
      indent = { enable = true, },
      autotag = { enalbe = true, },
      ensure_installed = {
        "cpp",
        "c",
        "c_sharp",
        "python",
        "lua",
        "bash",
        "vim",
        "vimdoc",
        "gitignore",
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_incremental = "<bs>", 
        },
      },

    })
  end,
}
