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
      local dapvt = require("nvim-dap-virtual-text")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      vim.fn.sign_define("DapBreakpoint", {
        text = "●", -- breakpoint icon
        texthl = "Error", -- red highlight
        linehl = "",
        numhl = "",
      })

      -- Conditional breakpoint (orange/yellow)
      vim.fn.sign_define("DapBreakpointCondition", {
        text = "◆",
        texthl = "WarningMsg",
        linehl = "",
        numhl = "",
      })

      -- Current execution line (arrow, can also be red if you want)
      vim.fn.sign_define("DapStopped", {
        text = "→",
        texthl = "Error", -- red arrow
        linehl = "Visual",
        numhl = "Normal",
      })

      local km = vim.keymap

      -- Execution control
      km.set("n", "<leader>dc", dap.continue, { desc = "Start / Continue" })
      km.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      km.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      km.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
      km.set("n", "<leader>dq", function()
        dap.terminate()
        dapui.close()
        dapvt.toggle()
      end, { desc = "Terminate debugger" })

      -- Breakpoints
      km.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      km.set("n", "<leader>dB", function()
        local cond = vim.fn.input("Condition: ")
        dap.set_breakpoint(cond)
      end, { desc = "Conditional Breakpoint" })
      km.set("n", "<leader>dl", dap.list_breakpoints, { desc = "List Breakpoints" })
      km.set("n", "<leader>dL", dap.clear_breakpoints, { desc = "Clear Breakpoints" })

      -- Stack navigation
      km.set("n", "<leader>dk", dap.up, { desc = "Stack Up" })
      km.set("n", "<leader>dj", dap.down, { desc = "Stack Down" })

      -- REPL / evaluation
      km.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
      km.set("n", "<leader>de", function()
        dapui.eval(vim.fn.input("Expression: "))
      end, { desc = "Evaluate Expression" })
      km.set("v", "<leader>de", function()
        dapui.eval()
      end, { desc = "Evaluate Selection" })

      -- UI and virtual text
      km.set("n", "<leader>dU", dapui.toggle, { desc = "Toggle DAP UI" })
      km.set("n", "<leader>dt", dapvt.toggle, { desc = "Toggle virtual text" })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dap.cpp")
    end,
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
      end,
    },
  },
}
