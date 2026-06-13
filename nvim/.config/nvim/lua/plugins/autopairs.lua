return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    -- blink.cmp handles bracket insertion on accept (auto_brackets), so no
    -- completion-plugin integration is needed here.
    require("nvim-autopairs").setup({
      check_ts = true,
    })
  end,
}
