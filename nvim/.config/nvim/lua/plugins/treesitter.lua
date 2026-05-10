return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    ts.install({
        "lua",
        "vim",
        "python",
        "javascript",
        "html",
        "markdown",
        "bash",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "html", "javascript", "c", "lua", "vim" },
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
