return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- VimTeX configuration goes here, e.g.
		vim.keymap.set("n", "<leader>lc", "<cmd>VimtexCompile<CR>", { desc = "Compile" })
		vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "View PDF" })
		vim.keymap.set("n", "<leader>ls", "<cmd>VimtexStop<CR>", { desc = "Stop compile" })
		vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", { desc = "Show errors" })

		vim.g.vimtex_view_method = "zathura"
	end,
}
