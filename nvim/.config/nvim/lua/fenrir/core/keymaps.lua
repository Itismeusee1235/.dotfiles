vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set({ "n" }, "j", "gj", { noremap = true, silent = true })
keymap.set({ "n" }, "k", "gk", { noremap = true, silent = true })

keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
keymap.set("i", "jkl", function()
	vim.cmd("stopinsert")
	vim.cmd("write")
end, { desc = "Exit insert mode and save" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Create Vertical split" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Create Horizontal split" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal sized" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<C-w>h", "<C-w>>", { desc = "Increase width of current split" })
keymap.set("n", "<C-w>l", "<C-w><", { desc = "Decrease width of current spit" })
keymap.set("n", "<C-w>j", "<C-w>-", { desc = "Decrease height of current split" })
keymap.set("n", "<C-w>k", "<C-w>+", { desc = "Increase height of current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Create a new tab" })
keymap.set("n", "<c-t>", "<cmd>tabnew<CR>", { desc = "Create a new tab" })

keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Delete current tab" })
keymap.set("n", "W", "<cmd>tabclose<CR>", { desc = "Delete current tab" })

keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "T", "<cmd>tabn<CR>", { desc = "Go to next tab" })

keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

keymap.set("n", "<c-k>", ":wincmd k<CR>")
keymap.set("n", "<c-j>", ":wincmd j<CR>")
keymap.set("n", "<c-h>", ":wincmd h<CR>")
keymap.set("n", "<c-l>", ":wincmd l<CR>")
