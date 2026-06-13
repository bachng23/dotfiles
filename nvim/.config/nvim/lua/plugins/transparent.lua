return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      enable = true,
      extra_groups = {
        "Normal",
        "NormalNC",
        "TelescopeBorder",
        "FzfLuaBorder",
        "FzfLuaNormal",
        "FzfLuaTitle",
        "FzfLuaPreviewBorder",
        "FzfLuaPreviewNormal",
        "FzfLuaPreviewTitle",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeWinSeparator",
        "NeoTreeEndOfBuffer",
      },
    })
    require("transparent").clear_prefix("NeoTree")
    vim.cmd("highlight Normal guibg=NONE")
    vim.cmd("highlight NormalNC guibg=NONE")
    vim.cmd("highlight CursorLine guibg=NONE")
  end,
}
