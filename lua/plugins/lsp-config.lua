return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "clangd",
        "ts_ls",
        "angularls",
        "html",
        "cssls",
        "jsonls",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      --vim.lsp.enable("lua_ls")
      --vim.lsp.enable("rust_analyzer")
      --vim.lsp.enable("clangd")

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
      })

      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.angularls.setup({
        capabilities = capabilities,
      })

      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities,
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
    end,
    opts = {},
  },
}
