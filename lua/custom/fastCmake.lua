vim.api.nvim_create_user_command("Configure", function()
  vim.cmd("!cmake -S . -B build -G Ninja "
    .. "-DCMAKE_C_COMPILER=clang "
    .. "-DCMAKE_CXX_COMPILER=clang++ "
    .. "-DCMAKE_BUILD_TYPE=Debug "
    .. "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
end, {})

vim.api.nvim_create_user_command("Build", function()
  vim.cmd("!cmake --build build -j")
end, {})

vim.api.nvim_create_user_command("Run", function()
  vim.cmd("!./build/bin/app")
end, {})
