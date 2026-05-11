# Linux Config

This repository contains my personal Linux configuration files (dotfiles).

## What's Inside

- **nixos/** - NixOS system configurations
- **sublime-text-3/** - Sublime Text 3 user settings and snippets
- **setup.sh** - Automated setup script for creating symbolic links

## Quick Start

1. Clone this repository to your home directory:
   ```bash
   git clone <your-repo-url> ~/linux-config
   cd ~/linux-config
   ```

2. Run the setup script:
   ```bash
   ./setup.sh
   ```

   This will create symbolic links from your home directory to the files in this repo.

## How It Works

The `setup.sh` script uses **symbolic links** to connect your system's config paths to this repository. This means:

- Any changes you make to configs are instantly tracked by Git
- No need to manually copy files after editing
- Safe to run multiple times (idempotent)
- Existing configs are automatically backed up before being replaced

## Adding New Dotfiles

To add a new configuration file or directory:

1. **Move the config into this repo** (keeping the same relative structure if you want):
   ```bash
   # Example: adding a bash config
   mkdir -p ~/linux-config/bash
   mv ~/.bashrc ~/linux-config/bash/.bashrc
   ```

2. **Add a link entry in `setup.sh`**:
   Open `setup.sh` and add a line inside the "Add your dotfiles" section:
   ```bash
   link_dotfile "bash/.bashrc" "$HOME/.bashrc"
   ```

3. **Run the setup script**:
   ```bash
   ./setup.sh
   ```

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "Add bash config"
   ```

## Sublime Text 3

The `sublime-text-3/Packages/User/` directory contains:

- **Custom snippets** (e.g., `cpp-main-frog.sublime-snippet`)
- **User preferences** (`Preferences.sublime-settings`)
- Any other personal Sublime Text customizations

### Using the C++ Snippet

In any C++ file, type `frog` and press `Tab` to expand the main function template.

### Adding New Snippets

1. Save new `.sublime-snippet` files into `sublime-text-3/Packages/User/`
2. They will be active immediately (no restart needed)
3. Commit them to this repo to keep them synced across machines

## Backup Policy

Whenever `setup.sh` replaces an existing file or directory, it automatically creates a timestamped backup in:

```
~/.dotfiles-backup-YYYYMMDD_HHMMSS/
```

You can safely delete these backups once you've confirmed everything works.

## Requirements

- Bash shell
- Standard Unix tools (`ln`, `mv`, `mkdir`, `readlink`)
- Git

## License

Personal use only. Modify as needed for your own setup.
