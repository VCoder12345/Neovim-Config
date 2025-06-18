return {
	{
		"mason-org/mason.nvim",
		opts = {
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "ts_ls", "angularls", "html", "cssls", "jsonls", "eslint" },
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
			local keymap = vim.keymap
			keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp hover info" })
			keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "lsp go to def." })
			keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "lsp go to declr." })
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "lsp code-action" })
		end,
		opts = {},
	},
}
