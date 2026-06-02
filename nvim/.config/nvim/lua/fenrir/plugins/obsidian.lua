return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	ft = "markdown",
	cmd = {
		"ObsidianBacklinks",
		"ObsidianDailies",
		"ObsidianExtractNote",
		"ObsidianFollowLink",
		"ObsidianLink",
		"ObsidianLinkNew",
		"ObsidianLinks",
		"ObsidianNew",
		"ObsidianNewFromTemplate",
		"ObsidianOpen",
		"ObsidianPasteImg",
		"ObsidianQuickSwitch",
		"ObsidianRename",
		"ObsidianSearch",
		"ObsidianTags",
		"ObsidianTemplate",
		"ObsidianToday",
		"ObsidianToggleCheckbox",
		"ObsidianTomorrow",
		"ObsidianTOC",
		"ObsidianYesterday",
	},

	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "Notes",
				path = "~/Knowledge/Mimir",
			},
		},

		notes_subdir = "Notes",
		new_notes_location = "current_dir",

		daily_notes = {
			folder = "Dailies",

			date_format = "%Y-%m-%d",
			alias_format = "%B %-d, %Y",

			default_tags = { "daily-notes" },

			template = nil,
		},

		completion = {
			nvim_cmp = true,

			min_chars = 2,
		},

		mappings = {
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},

			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},

			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},

		---@param title string|?
		---@return string
		note_id_func = function(title)
			local suffix = ""

			if title ~= nil then
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end

			return tostring(os.time()) .. "-" .. suffix
		end,

		---@param spec {id: string, dir: obsidian.Path, title: string|?}
		---@return string|obsidian.Path
		note_path_func = function(spec)
			local cwd = vim.fn.getcwd()
			local path = require("obsidian.path").new(cwd) / (spec.id .. ".md")
			-- print(path)
			return path
		end,

		-- wiki_link_func = "use_alias_only",
		wiki_link_func = function(opts)
			return require("obsidian.util").wiki_link_id_prefix(opts)
		end,

		markdown_link_func = function(opts)
			return require("obsidian.util").markdown_link(opts)
		end,

		preferred_link_style = "wiki",

		disable_frontmatter = false,

		picker = {
			name = "telescope.nvim",

			note_mappings = {
				new = "<C-x>",
				insert_link = "<C-l>",
			},

			tag_mappings = {
				tag_note = "<C-x>",
				insert_tag = "<C-l>",
			},

			sort_by = "modified",
			sort_reversed = true,
			search_max_lines = 1000,
			open_notes_in = "vsplit",
		},

		-- attachments = {
		-- 	img_folder = "Assets/Images",
		--
		-- 	--@return string
		-- 	img_name_func = function()
		-- 		return string.format("%s-", os.time())
		-- 	end,
		--
		-- 	--@param client obsidian.Client
		-- 	---@param path obsidian.Path the absolute path to the image file
		-- 	---@return string
		-- 	img_text_func = function(client, path)
		-- 		path = client:vault_relative_path(path) or path
		-- 		return string.format("![%s](%s)", path.name:gsub(" ", "_"), path)
		-- 	end,
		-- },
		attachments = {
			img_folder = "Assets/Images",

			img_name_func = function()
				-- get user input
				local input = vim.fn.input("Image name: ")

				-- replace spaces → _
				input = input:gsub("%s+", "_")

				-- remove weird chars (optional but good)
				input = input:gsub("[^%w%._-]", "")

				return os.date("%Y-%m-%d_%H-%M-%S") .. "-" .. input
			end,

			img_text_func = function(_, path)
				return string.format("![[%s]]", path.name)
			end,
		},
	},

	config = function(_, opts)
		require("obsidian").setup(opts)

		local keymap = vim.keymap
		keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "New note" })
		keymap.set("n", "<leader>oo", "<cmd>ObsidianQuickSwitch<CR>", { desc = "search and switch notes" })
		keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show back links" })
		keymap.set("n", "<leader>of", "<cmd>ObsidianSearch<CR>", { desc = "Searches in notes" })
		keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<CR>", { desc = "Makes today's note" })
		keymap.set("n", "<leader>od", "<cmd>ObsidianDailies<CR>", { desc = "Picker of Dailes" })
		keymap.set("v", "<leader>ol", "<cmd>ObsidianLinkNew<CR>", { desc = "Converts text to empty new note" })
		keymap.set("v", "<leader>ox", "<cmd>ObsidianExtractNote<CR>", { desc = "Puts text into new note" })
		keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Rename" })
		keymap.set("n", "<leader>op", "<cmd>ObsidianPasteImg<CR>", { desc = "Paste Image" })
	end,
}
