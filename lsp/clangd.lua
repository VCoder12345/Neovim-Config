return {
  cmd = { "clangd", "--background-index", "--header-insertion=iwyu" },
  root_markers = { ".clangd", ".git/", "compile_commands.json", "compile_flags.txt" },
  filetypes = { "c", "cpp" },
}
