return {
  cmd = { "slangd" },

  filetypes = {
    "shaderslang",
    "hlsl",
    "slang",
  },

  root_markers = { ".git/", "compile_commands.json", "CMakeLists.txt" },

  settings = {
    -- optional server settings
  },
}
