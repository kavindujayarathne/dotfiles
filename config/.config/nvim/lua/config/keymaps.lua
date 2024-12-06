-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Replacing the <Esc> with other keybindings for ease of use
map("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })

-- Move Lines
-- map("n", "<C-S-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
-- map("n", "<C-S-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
-- map("i", "<C-S-n>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
-- map("i", "<C-S-m>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
-- map("v", "<C-S-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
-- map("v", "<C-S-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Swap Windows Around
-- map("n", "<leader>wh", "<C-w>H", { desc = "Move window to the left" })
-- map("n", "<leader>wl", "<C-w>L", { desc = "Move window to the right" })
-- map("n", "<leader>wk", "<C-w>K", { desc = "Move window to the top" })
-- map("n", "<leader>wj", "<C-w>J", { desc = "Move window to the bottom" })
