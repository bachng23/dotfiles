return {
  "karb94/neoscroll.nvim",
  config = function()
    local neoscroll = require("neoscroll")
    neoscroll.setup({
      hide_cursor = false,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      duration_multiplier = 0.8,
      easing = "linear",
    })
    local keymap = {
      ["<C-e>"] = function() neoscroll.ctrl_u({ duration = 300 }) end,
      ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 300 }) end,
      ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450 }) end,
      ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450 }) end,
      ["zt"] = function() neoscroll.zt({ half_win_duration = 300 }) end,
      ["zz"] = function() neoscroll.zz({ half_win_duration = 300 }) end,
      ["zb"] = function() neoscroll.zb({ half_win_duration = 300 }) end,
    }
    local modes = { "n", "v", "x" }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
