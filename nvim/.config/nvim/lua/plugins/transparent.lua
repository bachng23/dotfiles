return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      enable = true,
      extra_groups = {
        "Normal",
        "NormalNC",
        "TelescopeBorder",
        "LualineNormal",
        "FzfLuaBorder",
        "FzfLuaNormal",
        "FzfLuaTitle",
        "FzfLuaPreviewBorder",
        "FzfLuaPreviewNormal",
        "FzfLuaPreviewTitle",
      },
    })
    require("transparent").clear_prefix("lualine")
    vim.cmd("highlight Normal guibg=NONE")
    vim.cmd("highlight Lualine guibg=NONE")
    vim.cmd("highlight Lualine guifg=NONE")
    vim.cmd("highlight NormalNC guibg=NONE")
    vim.cmd("highlight CursorLine guibg=NONE")
  end,
}
