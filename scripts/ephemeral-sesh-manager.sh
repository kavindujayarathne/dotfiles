#!/usr/bin/env bash

PROFILE_DIR="/tmp/ff-disposable-profile"
BACKUP_DIR="$HOME/EphemeralBrowsers"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="ff-backup-$TIMESTAMP.tar.gz.enc"

# Colors
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo "--------------------------------------"
echo -e "${YELLOW} Ephemeral Browser Session Manager ${RESET}"
echo "--------------------------------------"

# Fetch encryption password from Keychain
PASSWORD=$(security find-generic-password -a ephemeral-browser -s browser-script -w 2>/dev/null)
if [ -z "$PASSWORD" ]; then
  echo -e "${RED}[✘] Could not fetch encryption key from Keychain. Aborting.${RESET}"
  exit 1
fi

spinner() {
  local pid=$1
  local delay=0.1
  local spin='-\|/'
  while ps -p $pid >/dev/null 2>&1; do
    for i in $(seq 0 $((${#spin} - 1))); do
      printf "\r[*] Working... %c" "${spin:$i:1}"
      sleep $delay
    done
  done
  printf "\r" # clear the line when done
}

run() {
  # Run Firefox
  echo "[*] Launching Firefox with disposable profile..."
  /Applications/Firefox\ Developer\ Edition.app/Contents/MacOS/firefox -profile "$PROFILE_DIR" 2>/dev/null
}

quit() {
  # After quit → backup + wipe
  if [ -d "$PROFILE_DIR" ]; then
    echo "[*] Backing up current session..."

    # Remove old backup before creating new one
    rm -f "$BACKUP_DIR"/ff-backup-*.tar.gz.enc

    # Create a new encrypted backup
    tar -cz -C /tmp ff-disposable-profile | openssl enc -aes-256-cbc -salt -pbkdf2 \
      -pass pass:"$PASSWORD" -out "$BACKUP_DIR/$BACKUP_NAME" &
    spinner $!
    wait
    echo -e "${GREEN}[✔] Backup saved as $BACKUP_NAME${RESET}"

    # Delete the live profile
    rm -rf "$PROFILE_DIR"
    echo "[*] Live profile wiped from /tmp."

    # Notify macOS
    terminal-notifier -title "Firefox Ephemeral Backup" \
      -message "Profile encrypted as $BACKUP_NAME in ~/EphemeralBrowsers ✅"
  fi

  echo -e "${GREEN}Done.${RESET}"
}

session() {
  run
  quit
}

# Ensure backup dir exists
if [ ! -d "$BACKUP_DIR" ]; then
  echo "[*] No backup directory found → First run detected"
  echo "[*] Creating backup directory at $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"
  session
  exit 0
fi

# Check for existing backup
EXISTING_BACKUP=$(ls "$BACKUP_DIR"/ff-backup-*.tar.gz.enc 2>/dev/null | head -n 1)
if [ -f "$EXISTING_BACKUP" ]; then
  echo "[*] Found existing backup → restoring into /tmp..."
  rm -rf "$PROFILE_DIR"
  openssl enc -d -aes-256-cbc -pbkdf2 \
    -in "$EXISTING_BACKUP" \
    -pass pass:"$PASSWORD" | tar -xz -C /tmp/ &
  spinner $!
  wait
  echo -e "${GREEN}[✔] Previous session restored.${RESET}"
  run
  quit
else
  echo "[*] No backup found → starting a fresh ephemeral session."
  session
fi
