return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      -- Robust wrapper to prevent nil errors in lsp_document_symbols

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics" })
      vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "Telescope commits" })
      vim.keymap.set("n", "<leader>fr", builtin.current_buffer_fuzzy_find, { desc = "Telescope grep on current file" })

      vim.keymap.set("n", "<leader>fs", function()
        builtin.lsp_document_symbols({
          symbols = { "Class", "Struct", "Interface", "Function", "Method", "Constructor", "Trait" },
        })
      end, { desc = "Telescope lsp document symbols" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      require("telescope").load_extension("ui-select")
    end,
  },
}
