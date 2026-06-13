-- Các hàm/keymap tiện ích

-- <leader>cp: copy đường dẫn tuyệt đối của file hiện tại vào clipboard
vim.keymap.set("n", "<leader>cp", function()
    local filepath = vim.fn.expand("%:p")
    vim.fn.setreg("+", filepath)
    print("Copied: " .. filepath)
end, { desc = "Copy absolute file path" })

-- <leader>ce: copy nội dung diagnostic ngay dưới con trỏ vào clipboard
vim.keymap.set("n", "<leader>ce", function()
    local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
    if #diagnostics > 0 then
        local message = diagnostics[1].message
        vim.fn.setreg("+", message)
        print("Copied diagnostic: " .. message)
    else
        print("No diagnostic at cursor")
    end
end, { desc = "Copy diagnostic under cursor" })
