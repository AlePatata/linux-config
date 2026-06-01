# export LD_LIBRARY_PATH=$(find /nix/store -name "libGL.so.1" -exec dirname {} \; 2>/dev/null | head -1):$LD_LIBRARY_PATH
# export PRISMA_ENGINES_CHECKSUM_IGNORE_MISSING=1
# export PRISMA_QUERY_ENGINE_LIBRARY=$(find /nix/store -name "libquery_engine.node" | head -1)
# export PRISMA_SCHEMA_ENGINE_BINARY=$(find /nix/store -name "schema-engine" | head -1)
alias nixconf='nvim ~/linux-config/nixos/configuration.nix'
alias gs='git status'
alias cdd='cd ~ale/Desktop'
alias nvimconf='nvim ~/.config/nvim/'
alias buscaminas='minesweeper'
alias activate='source .venv/bin/activate'
alias clean='sudo nix-collect-garbage'

export PATH="$HOME/.local/bin:$PATH"
