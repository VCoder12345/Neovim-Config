return {
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xw",
				"<cmd>Trouble workspace_diagnostics toggle<cr>",
				desc = "open trouble workspace diagnostics",
			},
			{
				"<leader>xb",
				"<cmd>Trouble toggle filter.buf=0<cr>",
				desc = "open trouble buffer diagnostics",
			},
			{
				"<leader>xq",
				"<cmd>Trouble quickfix<cr>",
				desc = "open trouble quickfix list",
			},
			{
				"<leader>xl",
				"<cmd>Trouble loclist<cr>",
				desc = "open trouble location list",
			},
		},
	},
}
