-- return {
--   "nvim-treesitter/nvim-treesitter",
--   lazy = false,
--   build = ":TSUpdate",
--   config = function()
--     local configs = require("nvim-treesitter")
--
--     configs.setup({
--       auto_install = true,
--       highlight = { enable = true },
--       indent = { enable = true },
--     })
--
--
--     vim.opt.foldmethod = "expr"
--     vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--
--     vim.opt.foldcolumn = "0"
--     vim.opt.foldtext = ""
--     vim.opt.foldlevel = 99
--     vim.opt.foldlevelstart = 99
--   end,
-- }

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  opts = {
    indent = { enable = true },
    highlight = { enable = true },
    folds = { enable = true },
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "cpp",
      "c",
      "markdown",
    },
  },
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
      end,
    })
  end,
}
