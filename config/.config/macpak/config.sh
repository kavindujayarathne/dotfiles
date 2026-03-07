# config.sh

# Deletion
# 1 = prefer safe deletes via Trash, 0 = permanent removal (rm -rf)
USE_TRASH=1

# Brewfile integration
# 1 = auto-update Brewfile after installs and uninstalls, 0 = disable
AUTO_BREWFILE=1
# Override to change the Brewfile location
BREWFILE_PATH="$HOME/.config/brewfile/Brewfile"

# Caching
# Override to change the cache location
INDEX_PATH="$HOME/.cache/macpak/index.tsv"
# Cache freshness window in seconds (default: 86400 = 24h)
INDEX_TTL_SECS=86400
# 1 = use cached index for queries, 0 = query Homebrew live
USE_CACHE_FOR_QUERY=1

# Leftovers scanning
# 1 = scan for leftover files after uninstall, 0 = skip
AUTO_SCAN_AFTER_UNINSTALL=1
# Paths to scan for leftovers. Override to add or remove scan directories
ROOTS=(
  "/Applications"
  "/Library"
  "/private/etc"
  "/private/var/db/receipts"
  "/private/var/root/Library"
  "/private/var/log"
  "/opt/homebrew"
  "/usr/local"
  "/Users/Shared"
  "$HOME"
)
# Paths to exclude from leftover scans (empty by default)
EXCLUDES=(
  "/Library/Developer"
  "$HOME/Developer"
  "$HOME/dotfiles"
  "$HOME/.Trash"
  "$HOME/Library/Mobile Documents/"
  "/opt/homebrew/Library/Taps/homebrew/homebrew-cask/"
)
