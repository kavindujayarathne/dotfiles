-- Keykeymaps are automatically loaded on the VeryLazy event
-- Default keykeymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keykeymaps.lua
-- Add any additional keykeymaps here
local keymap = vim.keymap.set

-- Replacing the <Esc> with other keybindings for ease of use
keymap("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })

-- Move Lines
-- keymap("n", "<C-S-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
-- keymap("n", "<C-S-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
-- keymap("i", "<C-S-n>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
-- keymap("i", "<C-S-m>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
-- keymap("v", "<C-S-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
-- keymap("v", "<C-S-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Swap Windows Around
keymap("n", "<leader>wh", "<C-w>H", { desc = "Move window to the left" })
keymap("n", "<leader>wl", "<C-w>L", { desc = "Move window to the right" })
keymap("n", "<leader>wk", "<C-w>K", { desc = "Move window to the top" })
keymap("n", "<leader>wj", "<C-w>J", { desc = "Move window to the bottom" })
