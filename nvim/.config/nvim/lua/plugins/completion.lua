return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
      -- Load the VS Code style snippets (friendly-snippets) into LuaSnip.
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  {
    "saghen/blink.cmp",
    version = "1.*", -- uses the prebuilt fuzzy binary, no Rust toolchain needed
    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
    },
    opts = {
      -- Keep the old muscle memory from nvim-cmp.
      keymap = {
        preset = "default",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },

      snippets = { preset = "luasnip" },

      appearance = {
        -- We use JetBrainsMono Nerd Font (mono variant) for the kind icons.
        nerd_font_variant = "mono",
      },

      completion = {
        menu = {
          border = "single",
          -- Always prefer opening below the cursor (only flips up if there is
          -- genuinely no room left at the bottom of the screen).
          direction_priority = { "s", "n" },
          -- Border bg matches the menu bg, so the frame hugs the solid panel
          -- with no padding gap at the corners.
          winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
            },
          },
        },
        -- Zed-like documentation panel beside the list.
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "single",
            winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,Search:None",
          },
        },
        ghost_text = { enabled = true },
      },

      sources = {
        default = { "lsp", "snippets", "path", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
