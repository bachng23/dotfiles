return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        custom_highlights = function(colors)
          return {
            ColorColumn = { bg = colors.surface0 },
            IblIndent = { fg = colors.surface0 },
            IblWhitespace = { fg = colors.surface0 },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
