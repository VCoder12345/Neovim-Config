return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
      },
    })

    local kp = vim.keymap

    kp.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "format buffer" })
  end,
}
