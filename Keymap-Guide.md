# ⌨️ Dotfiles Keymap Guide

Tài liệu hướng dẫn nhanh các phím tắt cho Tmux và AeroSpace dựa trên cấu hình hiện tại của bạn.

---

## 🪟 AeroSpace (Tiling Window Manager)
*Sử dụng phím **Alt (Option)** làm phím điều hướng chính.*

### 1. Điều hướng & Di chuyển (Focus & Move)
- `Alt + h/j/k/l`: Chuyển focus sang cửa sổ Trái / Dưới / Trên / Phải.
- `Alt + Shift + h/j/k/l`: Di chuyển cửa sổ hiện tại sang Trái / Dưới / Trên / Phải.
- `Alt + Shift + f`: Bật/Tắt chế độ Toàn màn hình (Fullscreen).

### 2. Quản lý Workspace (Workspaces)
- `Alt + [Phím chữ]`: Nhảy đến Workspace tương ứng.
    - `T`: Terminal | `C`: Coding | `B`: Browser | `N`: Notes | `I`: AI (Claude/Codex) | `W`: Work (Discord/Zalo)
- `Alt + Shift + [Phím chữ]`: Đẩy cửa sổ hiện tại sang Workspace đó.
- `Alt + Tab`: Quay lại Workspace vừa sử dụng.
- `Alt + Shift + Tab`: Đẩy toàn bộ Workspace sang màn hình khác.

### 3. Layout & Resize
- `Alt + /`: Chuyển sang Layout Tiles (Ô gạch).
- `Alt + ,`: Chuyển sang Layout Accordion (Xếp lớp).
- `Alt + -` / `Alt + =`: Thu nhỏ / Phóng to cửa sổ thông minh.

### 4. Service Mode (`Alt + Shift + ;`)
*Nhấn tổ hợp này trước, sau đó nhấn phím đơn:*
- `Esc`: Reload cấu hình AeroSpace.
- `f`: Chuyển đổi giữa Floating (nổi) và Tiling (xếp gạch).
- `Backspace`: Đóng tất cả cửa sổ ngoại trừ cái đang chọn.

---

## 🐚 Tmux (Terminal Multiplexer)
*Phím Prefix mặc định: **Ctrl + a***

### 1. Chia màn hình (Splits)
- `Prefix + \`: Chia màn hình theo chiều dọc (Vertical).
- `Prefix + -`: Chia màn hình theo chiều ngang (Horizontal).
- `Prefix + m`: Phóng to/thu nhỏ Pane hiện tại (Zoom).

### 2. Điều hướng & Resize Panes
- `Ctrl + hjkl`: Di chuyển giữa các Pane (Tích hợp với Vim/Nvim).
- `Prefix + h/j/k/l`: Thay đổi kích thước Pane (giữ phím để lặp lại).

### 3. Quản lý Cửa sổ & Session
- `Prefix + c`: Tạo cửa sổ (Tab) mới.
- `Prefix + r`: Reload cấu hình tmux.
- `Prefix + 1, 2, 3...`: Nhảy đến cửa sổ số tương ứng.

### 4. Chế độ Copy (Copy Mode)
- `Prefix + [`: Vào chế độ Copy.
- `v`: Bắt đầu bôi đen (style Vim).
- `y`: Copy đoạn đã chọn.

---

## 🖋️ Neovim (Quick Remap)
- `<Space> + e`: Bật/Tắt Neo-tree.
- `<Space> + f`: Format code (Prettier/Ruff/Stylua).
- `<Space> + ca`: Code Action (LSP).
- `<Space> + rn`: Đổi tên biến (Rename).
- `K`: Xem tài liệu/Hover (LSP).
