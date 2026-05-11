return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- Cài đặt Ty và Ruff thay cho pylsp
      ensure_installed = { "lua_ls", "ty", "ruff" },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 1. Cấu hình TY: Chuyên trị Type Checking & Definition
      vim.lsp.config("ty", {
        capabilities = capabilities,
        on_new_config = function(config, root_dir)
          local venv_candidates = {
            root_dir .. "/.venv",
            root_dir .. "/venv",
          }
          for _, venv_path in ipairs(venv_candidates) do
            if vim.fn.executable(venv_path .. "/bin/python") == 1 then
              config.cmd_env = { VIRTUAL_ENV = venv_path }
              break
            end
          end
        end,
      })
      vim.lsp.enable("ty")

      -- 2. Cấu hình RUFF: Chuyên trị lỗi phong cách (Warning) và Format
      vim.lsp.config("ruff", {
        capabilities = capabilities,
        -- Tắt hover của Ruff nếu bạn muốn dùng hover của Ty/Pylsp
        on_attach = function(client, _)
          client.server_capabilities.hoverProvider = false
        end,
      })
      vim.lsp.enable("ruff")

      -- 3. Cấu hình LUA_LS (giữ nguyên của bạn)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- LSP keymap setting
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
    end,
  },
}
