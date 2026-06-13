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
require("floating-term")
require("vim-helpers")
require("input-switch")

-- Keymap navigation
vim.keymap.set('n', '<leader>w', ':Neotree toggle left<CR>', { desc = "Toggle Neo-tree" })

-- cmp window highlights (solid, so the popup isn't see-through over the
-- transparent editor; CmpBorder shares CmpNormal's bg so the border is seamless)
vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#1e1e2e" })
-- Border bg matches the menu bg so the whole popup is one solid block with the
-- frame line right on its edge (no padding gap at the corners). Pair with a
-- square border ("single") so there is no rounded arc for it to bleed past.
vim.api.nvim_set_hl(0, "CmpBorder", { bg = "#1e1e2e", fg = "#585b70" })
vim.api.nvim_set_hl(0, "CmpSel", { bg = "#313244", bold = true })

-- Diagnostic keymaps
-- <leader>e toggles the floating diagnostic window: closes it if already
-- open (instead of moving the cursor into it), opens it otherwise.
local diagnostic_float_winid = nil
vim.keymap.set('n', '<leader>e', function()
  if diagnostic_float_winid and vim.api.nvim_win_is_valid(diagnostic_float_winid) then
    vim.api.nvim_win_close(diagnostic_float_winid, true)
    diagnostic_float_winid = nil
  else
    diagnostic_float_winid = vim.diagnostic.open_float(nil, { focus = false })
  end
end, { desc = "Toggle floating diagnostic" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

