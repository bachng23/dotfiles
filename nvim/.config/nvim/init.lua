-- pull lazy vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

-- Keymap navigation
vim.keymap.set('n', '<leader>E', function()
    local current_filetype = vim.bo.filetype
    if current_filetype == "neo-tree" then
        vim.cmd("wincmd p") -- "p" là "previous": Quay lại cửa sổ trước đó
    else
        vim.cmd("Neotree focus") -- Nhảy vào cửa sổ Neo-tree
    end
end, { desc = "Chuyển nhanh giữa Code và Neo-tree" })

