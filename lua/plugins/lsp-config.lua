return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "cmakelint",
        "mypy",
        "ruff",
        "clang-format",
        "debugpy",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "ts_ls",
        "angularls",
        "html",
        "cssls",
        "jsonls",
        "neocmake",
        "slangd",
        "pyright",
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
      --vim.lsp.enable("lua_ls")
      --vim.lsp.enable("rust_analyzer")
      --vim.lsp.enable("clangd")

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      -- lspconfig.rust_analyzer.setup({
      --   capabilities = capabilities,
      -- })

      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            "Makefile",
            "configure.ac",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja"
          )(fname) or require("lspconfig.util").root_pattern(
            "compile_commands.json",
            "compile_flags.txt"
          )(fname) or require("lspconfig.util").find_git_ancestor(fname)
        end,
      })

      lspconfig.ocamllsp.setup({
        cmd = { "ocamllsp" },
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

      lspconfig.neocmake.setup({
        capabilities = capabilities,
      })

      lspconfig.slangd.setup({
        capabilities = capabilities,
      })

      lspconfig.pyright.setup({
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
