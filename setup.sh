#!/bin/bash
# Restore dotfiles by symlinking this repo into $HOME.
# Existing files are backed up to <name>.bak
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    # Back up existing file (unless it already points at our source)
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        if [ "$(readlink "$dst")" != "$src" ]; then
            mv "$dst" "$dst.bak"
        fi
    fi
    ln -sfn "$src" "$dst"
    echo "linked $dst -> $src"
}

# Home directory
link "$DIR/.gitconfig"       "$HOME/.gitconfig"
link "$DIR/.zprofile"        "$HOME/.zprofile"
link "$DIR/.zshrc"           "$HOME/.zshrc"
link "$DIR/.vimrc"           "$HOME/.vimrc"
link "$DIR/.hushlogin"       "$HOME/.hushlogin"
link "$DIR/.aerospace.toml"  "$HOME/.aerospace.toml"

# SSH (config only - private keys are NOT in this repo, restore them yourself)
link "$DIR/.ssh/config" "$HOME/.ssh/config"
chmod 600 "$DIR/.ssh/config" "$HOME/.ssh/config" 2>/dev/null || true

# ~/.config
link "$DIR/.config/fish"  "$HOME/.config/fish"
link "$DIR/.config/nvim"  "$HOME/.config/nvim"
link "$DIR/.config/kitty" "$HOME/.config/kitty"
link "$DIR/.config/zed"   "$HOME/.config/zed"

echo "Done. Open a new shell to pick everything up."
