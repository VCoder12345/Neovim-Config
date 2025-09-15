return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.cmakelang,
        null_ls.builtins.formatting.sql_formatter,
      },
    })

    local kp = vim.keymap

		kp.set("n", "<leader>rf", vim.lsp.buf.format, { desc = "format buffer" })
	end,
}
