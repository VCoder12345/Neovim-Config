local dap = require("dap")
local install_root_dir = vim.fn.stdpath("data") .. "\\mason"
local extension_path = install_root_dir .. "\\packages\\codelldb\\extension\\"
local codelldb_path = extension_path .. "adapter\\codelldb"
local last_cmd = vim.fn.getcwd() .. "\\"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },

    -- On windows you may have to uncomment this:
    detached = false,
  },
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      local cmd = vim.fn.input("Path to executable: ", last_cmd, "file")
      last_cmd = cmd
      return cmd
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
