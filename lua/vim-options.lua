local opt = vim.opt
opt.relativenumber = true
opt.number = true 

opt.wrap = false
opt.tabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.shiftwidth = 2
opt.smarttab = true

opt.ignorecase = true
opt.smartcase = true



opt.signcolumn = "yes"

opt.fileformat = "unix"
opt.fileformats = {"unix", "dos"}


--opt.clipboard:append("unnamedplus") -- use system clipboard as default register

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlights text when yanking",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
