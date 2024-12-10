require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- set up creating a note from a template and how to easily navigate them
map(
  "n",
  "<leader>ot",
  "<cmd>ObsidianNewFromTemplate DefaultTemplate<cr>",
  { desc = "Obsidian: Create Note from Template" }
)
map("n", "<leader>oT", "<cmd>ObsidianTemplate<cr>", { desc = "Obsidian: Create Note from Template" })
map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float(nil, { scope = 'line' })<cr>", { desc = "Diagnostic" })
map(
  "n",
  "<leader>mn",
  ":Telescope find_files search_dirs={'/home/code/vaults/personal/CodesNotes/'}<cr>",
  { desc = "find my notes" }
)

map(
  "n",
  "<leader>cn",
  ":Telescope find_files search_dirs={'/home/code/vaults/personal/Notes/'}<cr>",
  { desc = "find notes" }
)

-- enter zen mode
map("n", "<leader>z", ":ZenMode<cr>", { desc = "Enter zen mode" })

-- quit the active neovim window
map("n", "<leader>q", ":q<cr>", { desc = "Quit the window in focus" })

-- Move lines up and down in normal mode
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)

-- Move selected lines up and down in visual mode
map("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Map `d` to delete without copying
map("n", "<leader>dl", '"_d<cr>', opts)
map("v", "<leader>dl", '"_d<cr>', opts)

-- move to the end and beginning of the line
map("n", "sh", "^", { desc = "go to the begining of the line" })
map("n", "sl", "$", { desc = "go to the end of the line" })

-- search through todos
map("n", "<leader>td", ":TodoTelescope<cr>", { desc = "search todos" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
