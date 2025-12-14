vim.lsp.enable({
  "clangd",
  "lua_ls",
  "ocamllsp",
  "ty",
  "pyright",
  "ts_ls",
  "cssls",
  "jsonls",
  "html_ls",
  "neocmake"
})

vim.diagnostic.config({
  -- virtual_lines = true,
  virtual_text = true,
  underline = true,
  update_in_insert = false,
})

local keymap = vim.keymap
keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp hover info" })
keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "lsp go to def." })
keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "lsp go to declr." })
keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "lsp code-action" })
keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "show LSP references" })
keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "show LSP implementations" })
keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "show LSP type definitions" })
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })
keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "show buffer diagnostics" })
keymap.set("n", "<leader>he", "<cmd>ClangdSwitchSourceHeader<CR>", { desc = "switch source/header" })

