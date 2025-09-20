vim.g.mapleader = " "

local keymap = vim.keymap
keymap.set("i", "jk", "<Esc>", {desc = "Escape"})
keymap.set("n", "<C-h>", "<C-w>h", {desc = "moving to left window"})
keymap.set("n", "<C-j>", "<C-w>j", {desc = "moving to lower window"})
keymap.set("n", "<C-k>", "<C-w>k", {desc = "moving to upper window"})
keymap.set("n", "<C-l>", "<C-w>l", {desc = "moving to right window"})

keymap.set("n", "<leader>nh", ":nohl<CR>", {desc = "Clear serach highlights"})

keymap.set("n", "<leader>sv", "<C-w>v", {desc = "Split window vertically"})
keymap.set("n", "<leader>sh", "<C-w>s", {desc = "Split window horizontally"})
keymap.set("n", "<leader>se", "<C-w>=", {desc = "Make splits equal size"})
keymap.set("n", "<leader>sx", "<cmd>close<CR>", {desc = "Close current split"})

keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>")
keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>")
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

--buffers
keymap.set("n", "<TAB>", ":bn<CR>")
keymap.set("n", "<S-TAB>", ":bp<CR>")
