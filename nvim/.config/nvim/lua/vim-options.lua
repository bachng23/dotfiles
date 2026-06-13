vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "white" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ead84e" })
vim.api.nvim_set_option("clipboard", "unnamed")
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- auto clear search highlight once you stop navigating matches
vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local key = vim.fn.keytrans(char)
        local keep_hl = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, key)
        if vim.opt.hlsearch:get() ~= keep_hl then
            vim.opt.hlsearch = keep_hl
        end
    end
end, vim.api.nvim_create_namespace("auto_hlsearch"))
-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- paste over highlight word
vim.keymap.set("x", "<leader>p", '"_dP')
vim.opt.colorcolumn = "94"
vim.opt.clipboard = "unnamedplus"
-- Keep the cursor away from the screen edges so the completion menu always
-- has room to open below it.
vim.opt.scrolloff = 8
-- wrap text
-- vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.linebreak = true
-- vim.opt.breakindent = true
-- vim.opt.showbreak = "↳\\"
-- fk llm-ls
local notify_original = vim.notify
vim.notify = function(msg, ...)
    if
        msg
        and (
            msg:match("position_encoding param is required")
            or msg:match("Defaulting to position encoding of the first client")
            or msg:match("multiple different client offset_encodings")
        )
    then
        return
    end
    return notify_original(msg, ...)
end
