return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap
		local lspconfig = require("lspconfig")

		-- =========================
		-- KEYMAPS (LspAttach)
		-- =========================
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				keymap.set("n", "gr", vim.lsp.buf.references, opts)
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
			end,
		})

		-- =========================
		-- CAPABILITIES (for cmp)
		-- =========================
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- =========================
		-- DIAGNOSTIC SIGNS
		-- =========================
		local signs = {
			Error = " ",
			Warn = " ",
			Hint = "󰠠 ",
			Info = " ",
		}

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- =========================
		-- NEW LSP CONFIG (Neovim 0.11+)
		-- =========================
		local servers = {
			clangd = {
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "cuda", "c++", "cuh", "cu" },
				capabilities = capabilities,
			},

			lua_ls = {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},

			pylsp = {
				capabilities = capabilities,
			},

			svls = {
				cmd = { "svls" },
				filetypes = { "verilog", "systemverilog" },
				capabilities = capabilities,
			},

			qmlls = {
				cmd = { "qmlls6" },
				filetypes = { "qml" },
				settings = {
					qml = {
						importPaths = {
							"/usr/lib/qt6/qml",
						},
					},
				},
				capabilities = capabilities,
			},
		}

		-- Register + enable servers
		for name, config in pairs(servers) do
			vim.lsp.config(name, config)
			vim.lsp.enable(name)
		end
	end,
}
