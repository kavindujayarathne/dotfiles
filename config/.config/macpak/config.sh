# --- config for macpak---

# Brewfile integration
AUTO_BREWFILE=1 # set 0 to disable Brewfile dump
BREWFILE_PATH="$HOME/.config/brewfile/Brewfile"

# Caching
INDEX_PATH="$HOME/.cache/macpak/index.tsv"
INDEX_TTL_SECS=86400 #24h
# use cached index even when a query is supplied (fast, default=1).
# set to 0 in ~/.config/macops/config.sh to force live `brew search` for queries.
USE_CACHE_FOR_QUERY=1

# Leftovers scanning
AUTO_SCAN_AFTER_UNINSTALL=1

# ROOTS=(
#   "/Applications"
#   "/Library"
#   "/private/etc"
#   "/private/var/db/receipts"
#   "/private/var/root/Library"
#   "/private/var/log"
#   "/opt/homebrew"
#   "/usr/local"
#   "/Users/Shared"
#   "$HOME"
# )

EXCLUDES=(
  "/Library/Developer"
  "$HOME/Developer"
  "$HOME/dotfiles"
  "$HOME/.Trash"
  "$HOME/Library/Mobile Documents/"
  "/opt/homebrew/Library/Taps/homebrew/homebrew-cask/"
)
