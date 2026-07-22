return {
  -- Install the vscode-js-debug adapter via Mason (prebuilt, no source build needed)
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "js-debug-adapter")
    end,
  },

  -- Register Node/JavaScript adapters and launch/attach configurations
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      local js_debug = vim.fn.stdpath("data")
        .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

      -- Both Node and Chrome debugging are served by the same dapDebugServer.js
      for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
        dap.adapters[adapter] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = { js_debug, "${port}" },
          },
        }
      end

      local node_configs = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch current Node file",
          -- Resolve at launch time and fall back to a prompt so pressing
          -- <continue> from a non-file window (e.g. the dap-repl) can't try
          -- to run a buffer name like "[dap-repl-15]" as a module.
          program = function()
            local file = vim.fn.expand("%:p")
            if file == "" or vim.fn.filereadable(file) == 0 then
              return vim.fn.input("Path to file: ", vim.fn.getcwd() .. "/", "file")
            end
            return file
          end,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          -- Run in a real terminal buffer so interactive programs (e.g. a
          -- shell REPL reading from stdin) can receive typed input.
          console = "integratedTerminal",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach on port 9229 (--inspect)",
          port = 9229,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
      }

      local chrome_configs = {
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome against localhost:3000",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-chrome",
          request = "attach",
          name = "Attach to Chrome on port 9222",
          port = 9222,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
      }

      for _, ft in ipairs({ "javascript", "typescript" }) do
        dap.configurations[ft] = node_configs
      end

      -- React/browser filetypes get both Node and Chrome configurations
      for _, ft in ipairs({ "javascriptreact", "typescriptreact" }) do
        dap.configurations[ft] = vim.list_extend(vim.deepcopy(node_configs), chrome_configs)
      end
    end,
  },
}
