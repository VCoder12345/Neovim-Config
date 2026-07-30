return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "lewis6991/async.nvim",
    },
    lazy = false,
    opts = {},
    config = function()
      require("refactoring").setup({
        prompt_func_return_type = {
          cpp = true,
        },

        prompt_func_param_type = {
          cpp = true,
        },
      })

      local km = vim.keymap

      km.set("x", "<leader>re", ":Refactor extract ")
      km.set("x", "<leader>rf", ":Refactor extract_to_file ")

      km.set("x", "<leader>rv", ":Refactor extract_var ")

      km.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

      km.set("n", "<leader>rI", ":Refactor inline_func")

      km.set("n", "<leader>rb", ":Refactor extract_block")
      km.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

      km.set({ "n", "x" }, "<leader>rr", function()
        require("telescope").extensions.refactoring.refactors()
      end)
    end,
  },
}
