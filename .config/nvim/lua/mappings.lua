require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- set up creating a note from a template
map("n", "<leader>ot", "<cmd>ObsidianNewFromTemplate DefaultTemplate<cr>", { desc = "Obsidian: Create Note from Template" })
map("n", "<leader>oT", "<cmd>ObsidianTemplate<cr>", { desc = "Obsidian: Create Note from Template" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
