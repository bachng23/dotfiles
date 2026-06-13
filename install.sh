#!/usr/bin/env bash
#
# Bootstrap dotfiles on a fresh macOS install.
# Idempotent: safe to run multiple times.
#
#   ./install.sh
#
set -euo pipefail

# Resolve the directory this script lives in (the dotfiles repo root).
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(nvim tmux zsh)

info()  { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
warn()  { printf '\033[1;33m!!\033[0m %s\n' "$1"; }

# ---------------------------------------------------------------------------
# 1. Homebrew
# ---------------------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Make brew available for the rest of this script (Apple Silicon path).
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  info "Homebrew already installed."
fi

# ---------------------------------------------------------------------------
# 2. Packages
# ---------------------------------------------------------------------------
info "Installing packages (stow, neovim, tmux, ripgrep, fd, fzf, stylua, prettier)..."
brew install stow neovim tmux ripgrep fd fzf stylua prettier

# ---------------------------------------------------------------------------
# 3. Stow the dotfiles into $HOME
# ---------------------------------------------------------------------------
# If a real (non-symlink) config already exists, back it up so stow won't fail.
STOW_TARGETS=(
  "$HOME/.config/nvim"
  "$HOME/.config/tmux"
  "$HOME/.zshrc"
  "$HOME/.p10k.zsh"
)
for target in "${STOW_TARGETS[@]}"; do
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
    warn "Existing $target found — backing up to $backup"
    mv "$target" "$backup"
  fi
done

info "Stowing: ${PACKAGES[*]}"
cd "$DOTFILES_DIR"
stow -v -t "$HOME" "${PACKAGES[@]}"

# ---------------------------------------------------------------------------
# 4. tmux: TPM (Tmux Plugin Manager) + plugins
# ---------------------------------------------------------------------------
# tmux.conf runs '~/.tmux/plugins/tpm/tpm'; plugins themselves install into
# ~/.config/tmux/plugins (TPM's XDG default), which is git-ignored.
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  info "Cloning TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  info "TPM already present."
fi

info "Installing tmux plugins..."
"$TPM_DIR/bin/install_plugins" || warn "TPM install reported an issue (often fine on first run)."

# ---------------------------------------------------------------------------
# 5. Neovim: install lazy.nvim plugins headlessly
# ---------------------------------------------------------------------------
info "Syncing Neovim plugins (lazy.nvim)..."
nvim --headless "+Lazy! sync" +qa || warn "Neovim plugin sync reported an issue."

info "Done! Open a new shell, then 'nvim' and 'tmux' are ready to go."
