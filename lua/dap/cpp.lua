local dap = require("dap")
local install_root_dir = vim.fn.stdpath("data") .. "\\mason"
local extension_path = install_root_dir .. "\\packages\\codelldb\\extension\\"
local codelldb_path = extension_path .. "adapter\\codelldb"
-- local last_cmd = vim.fn.getcwd() .. "\\"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
    timeout = 0,

    -- On windows you may have to uncomment this:
    detached = false,
  },
}
local last_cmd_file = vim.fn.getcwd() .. "/.last_exe"

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      -- Try to read the last command from file
      local last_cmd = vim.fn.getcwd() .. "\\" -- fallback
      if vim.fn.filereadable(last_cmd_file) == 1 then
        local lines = vim.fn.readfile(last_cmd_file)
        if #lines > 0 then
          last_cmd = lines[1]
        end
      end

      -- Ask user for executable, defaulting to last_cmd
      local cmd = vim.fn.input("Path to executable: ", last_cmd, "file")

      -- Save the selected command for next time
      vim.fn.writefile({cmd}, last_cmd_file)

      return cmd
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    console = "externalTerminal",
    detached = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
