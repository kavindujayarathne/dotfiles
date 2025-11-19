# --- config (edit to taste or source ~/.config/macops/config.sh) ---
# ROOTS=("$HOME" "/Applications" "/Library" "/private/var/folders" "/private/var/root/Library" "/System/Volumes/Data")
# ROOTS=("$HOME")
# EXCLUDES=("$HOME/Developer")      # add more if noisy
# USE_TRASH=0
# AUTO_BREWFILE=${AUTO_BREWFILE:-1} # set 0 to disable Brewfile dump
# BREWFILE_PATH=${BREWFILE_PATH:-"$HOME/.config/brewfile/Brewfile"}

# Cache dir (XDG-aware, user-overridable)
# CACHE_DIR="$HOME/test"
# INDEX_PATH="$HOME/test/index.tsv"
# INDEX_TTL_SECS="${INDEX_TTL_SECS:-86400}" # 24h

# Use cached index even when a query is supplied (fast, default=1).
# Set to 0 in ~/.config/macops/config.sh to force live `brew search` for queries.
# USE_CACHE_FOR_QUERY=0

# AUTO_SCAN_AFTER_UNINSTALL=0
# AUTO_BREWFILE=0

#TODO: add mobile documents here
EXCLUDES=("/Library/Developer" "$HOME/Developer" "$HOME/dotfiles" "$HOME/.Trash")
