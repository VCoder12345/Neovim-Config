return {
  cmd = { "glsl_analyzer" },

  filetypes = {
    "glsl",
    "vert",
    "tesc",
    "tese",
    "geom",
    "frag",
    "comp",
    "vs",
    "fs"
  },
  
  root_markers = { ".git/", "compile_commands.json", "CMakeLists.txt" },

}
