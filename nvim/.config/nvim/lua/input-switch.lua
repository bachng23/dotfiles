-- Tự đổi bàn phím theo focus của nvim:
--   - Vào / focus nvim  -> ép tiếng Anh (code luôn dùng tiếng Anh)
--   - Rời / mất focus    -> trả về layout tiếng Việt đang dùng (vd AI CLI ở pane khác)
-- Yêu cầu: macism (brew install laishulu/homebrew/macism) + macOS.
-- Không hardcode ID tiếng Việt: tự "học" layout không-phải-English mà bạn đang gõ.

local sysname = vim.loop.os_uname().sysname
if sysname ~= "Darwin" then
    return
end

local macism = vim.fn.exepath("macism")
if macism == "" then
    return -- chưa cài macism thì bỏ qua, không gây lỗi
end

local english = "com.apple.keylayout.Australian" -- layout tiếng Anh của bạn
local native = nil -- layout tiếng Việt sẽ được học tự động

-- Đọc input source hiện tại (đồng bộ, nhanh)
local function current_layout()
    local f = io.popen(macism)
    if not f then
        return nil
    end
    local out = f:read("*a") or ""
    f:close()
    return (out:gsub("%s+", ""))
end

-- Đổi input source (không chặn UI)
local function switch_to(id)
    if id and id ~= "" then
        vim.fn.jobstart({ macism, id })
    end
end

-- Vào nvim: nhớ layout tiếng Việt nếu đang bật, rồi ép English
local function to_english()
    local cur = current_layout()
    if cur and cur ~= english then
        native = cur -- học layout tiếng Việt để khôi phục sau
    end
    switch_to(english)
end

-- Rời nvim: trả về layout tiếng Việt đã học
local function to_native()
    switch_to(native)
end

vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, { callback = to_english })
vim.api.nvim_create_autocmd({ "FocusLost", "VimLeavePre", "VimSuspend" }, { callback = to_native })
