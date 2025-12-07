return {
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        definition = {
          keys = {
            edit = "<CR>",
            vsplit = "v",
            split = "s",
            tabe = "t",
            quit = "q",
          },
        },
      })

      vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", {desc= "Peek definition"})
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons",  -- optional
    },
  },
}
