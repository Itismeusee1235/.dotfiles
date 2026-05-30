return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local nvimtree = require("nvim-tree")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 35,
				relativenumber = true,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				expand_all = false,
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},

			update_focused_file = {
				enable = true,
				update_root = false,
			},

			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { buffer = bufnr, noremap = true, silent = true, desc = desc }
				end
				vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open file/folder"))
				vim.keymap.set("n", "r<CR>", function()
					local node = api.tree.get_node_under_cursor()

					if node.type == "directory" then
						api.tree.change_root_to_node(node)
						vim.cmd("lcd " .. vim.fn.fnameescape(node.absolute_path))
					else
						api.node.open.edit()
					end
				end, opts("Enter Directory"))

				vim.keymap.set("n", "e<CR>", function()
					local node = api.tree.get_node_under_cursor()

					if node.type == "directory" then
						vim.cmd("lcd " .. vim.fn.fnameescape(node.absolute_path))
						api.node.open.edit()
					else
						api.node.open.edit()
					end
				end, opts("Enter Directory"))
			end,
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
