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

keymap.set("n", "<leader>gg", "<C-o>", {desc = "go back"});
keymap.set("n", "<CR>", "o<Esc>");
keymap.set("n", "<leader>O", "O<Esc>");

keymap.set("v", "<leader>y", '"+y', {desc = "yank selection to clipboard"})
keymap.set("n", "<leader>Y", '"+yg_', {desc = "yank to clipboard"})
keymap.set("n", "<leader>y", '"+y', {desc = "yank to clipboard"})
keymap.set("n", "<leader>yy", '"+yy', {desc = "yank line to clipboard"})

keymap.set("n", "<leader>p", '"+p', {desc = "paste from clipboard"})
keymap.set("n", "<leader>P", '"+P', {desc = "paste from clipboard"})
keymap.set("v", "<leader>p", '"+p', {desc = "paste from clipboard"})
keymap.set("v", "<leader>P", '"+P', {desc = "paste from clipboard"})

keymap.set("n", "ü", "^")
keymap.set("v", "ü", "^")

-- making coding faster by replacing unused characters often used ones
local feed = vim.api.nvim_feedkeys
local function imap_insert(lhs, rhs)
    vim.keymap.set("i", lhs, function()
        feed(rhs, "i", false)
    end)
end

imap_insert("ö", ";")
imap_insert("ä", "{")
imap_insert("$", "}")
imap_insert("ü", "[")
imap_insert("¨", "]")


keymap.set("v", "<leader>y", '"+y', {desc = "yank selection to clipboard"})
keymap.set("n", "<leader>Y", '"+yg_', {desc = "yank to clipboard"})
keymap.set("n", "<leader>y", '"+y', {desc = "yank to clipboard"})
keymap.set("n", "<leader>yy", '"+yy', {desc = "yank line to clipboard"})

keymap.set("n", "<leader>p", '"+p', {desc = "paste from clipboard"})
keymap.set("n", "<leader>P", '"+P', {desc = "paste from clipboard"})
keymap.set("v", "<leader>p", '"+p', {desc = "paste from clipboard"})
keymap.set("v", "<leader>P", '"+P', {desc = "paste from clipboard"})


--buffers
keymap.set("n", "<TAB>", ":bn<CR>")
keymap.set("n", "<S-TAB>", ":bp<CR>")
