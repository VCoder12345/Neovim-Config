return {
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local km = vim.keymap
      km.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
      km.set("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "Start or continue the debugger" })
      km.set("n", "<leader>di", "<cmd> DapStepInto <CR>", { desc = "Step Into" })
      km.set("n", "<leader>do", "<cmd> DapStepOver <CR>", { desc = "Step Over" })
      km.set("n", "<leader>du", "<cmd> DapStepOut <CR>", { desc = "Step Out" })
      km.set("n", "<leader>dq", function()
        require("dap").terminate()
        require("dapui").close()
        require("nvim-dap-virtual-text").toggle()
      end, { desc = "Terminate debugger" })
      km.set("n", "<leader>dl", function()
        require("dap").list_breakpoints()
      end, { desc = "List Breakpoints" })
    end,
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
      ensure_installed = {
        "codelldb",
      },
    },
    {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      dependencies = {
        "mfussenegger/nvim-dap",
      },
      config = function(_, opts)
        local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
        require("dap-python").setup(path)
      end
    },
  },
}
