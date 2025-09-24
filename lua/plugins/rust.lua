return {
  {
    "rust-lang/rust.vim",
    ft = "rust" ,
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = '^6',
    build = "rustup component add rust-analyzer",
  },
  
}
