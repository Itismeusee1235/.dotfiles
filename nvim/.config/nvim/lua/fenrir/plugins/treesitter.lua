return {
	"nvim-treesitter/nvim-treesitter",
	tag = "v0.10.0",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",

	dependencies = {
		"windwp/nvim-ts-autotag",
	},

	config = function()
		local ok, ts = pcall(require, "nvim-treesitter.configs")
		if not ok then
			return
		end

		require("nvim-ts-autotag").setup()

		ts.setup({
			ensure_installed = {
				"cpp",
				"c",
				"python",
				"lua",
				"bash",
				"vim",
				"vimdoc",
				"gitignore",
				"markdown",
				"markdown_inline",
			},

			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
