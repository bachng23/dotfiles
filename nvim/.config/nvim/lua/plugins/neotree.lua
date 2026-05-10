return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false, -- neo-tree will lazily load itself
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- Hiện các file bị ẩn
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.keymap.set("n", "<leader>e", ":Neotree toggle left<CR>", {})
  end,
}
