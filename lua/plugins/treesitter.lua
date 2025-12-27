return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })


    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    vim.opt.foldcolumn = "0"
    vim.opt.foldtext = ""
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
}
