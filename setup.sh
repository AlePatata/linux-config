#!/usr/bin/env bash

# Dotfiles Setup Script
# Run this script to create symbolic links from your home directory to this repo.
# It is idempotent: safe to run multiple times.

set -euo pipefail

# Get the directory where this script is located (the repo root)
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"

# Helper: create a symbolic link
# Usage: link_dotfile <source_in_repo> <target_in_home>
link_dotfile() {
    local source_path="$REPO_DIR/$1"
    local target_path="$2"

    # Skip if source doesn't exist
    if [[ ! -e "$source_path" ]]; then
        echo "[SKIP] Source not found: $source_path"
        return
    fi

    # Create parent directory of target if needed
    local parent_dir
    parent_dir="$(dirname "$target_path")"
    if [[ ! -d "$parent_dir" ]]; then
        echo "[DIR]  Creating directory: $parent_dir"
        mkdir -p "$parent_dir"
    fi

    # If target already exists and is not a symlink to our source, back it up
    if [[ -e "$target_path" || -L "$target_path" ]]; then
        if [[ "$(readlink -f "$target_path" 2>/dev/null || true)" == "$(readlink -f "$source_path" 2>/dev/null || true)" ]]; then
            echo "[OK]   Already linked: $target_path"
            return
        fi

        echo "[BACKUP] $target_path -> $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        mv "$target_path" "$BACKUP_DIR/"
    fi

    echo "[LINK] $target_path -> $source_path"
    ln -s "$source_path" "$target_path"
}

echo "========================================"
echo "  Dotfiles Setup"
echo "  Repo: $REPO_DIR"
echo "========================================"
echo ""

# -----------------------------------------
# Add your dotfiles below
# Format: link_dotfile "path_in_repo" "path_in_home"
# -----------------------------------------

# Sublime Text 3 - User packages
link_dotfile "sublime-text-3/Packages/User" "$HOME/.config/sublime-text-3/Packages/User"

# Example: Bash config
# link_dotfile "bash/.bashrc" "$HOME/.bashrc"

# Example: Git config
# link_dotfile "git/.gitconfig" "$HOME/.gitconfig"

# Example: Neovim config
# link_dotfile "nvim" "$HOME/.config/nvim"

# -----------------------------------------

echo ""
echo "========================================"
echo "  Setup Complete!"
echo "========================================"

if [[ -d "$BACKUP_DIR" ]]; then
    echo ""
    echo "Backups saved to: $BACKUP_DIR"
fi
