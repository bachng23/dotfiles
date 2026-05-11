return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      winopts = {
        height = 0.85,
        width = 0.90,
        preview = {
          layout = "horizontal",
        },
      },
      fzf_colors = {
        true,
        bg = "-1",
        gutter = "-1",
      },
      keymap = {
        fzf = { ["ctrl-q"] = "select-all+accept" },
      },
    })
    vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>pf", fzf.git_files, { desc = "Find Git Files" })
    vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help Tags" })
  end,
}
