#!/usr/bin/env bash

# actions array
actions=("stow" "unstow")

# Integrating fzf with actions array
action=$(printf "%s\n" "${actions[@]}" | fzf --height 15% --color fg:#ebdbb2,hl:#fabd2f --prompt 'Choose an action: ' --header 'Actions' --border)

# Check if the user made a selection
if [[ -z "$action" ]]; then
  echo "No action selected, exiting..."
  exit 1
fi

# Get list of directories (packages) in the current folder (dotfiles)
packages=(*/)
packages=("${packages[@]%/}") # Remove trailing slashes

# Display all packages for selection and allow multiple choices for exclusion
excluded_packages=$(printf "%s\n" "${packages[@]}" | fzf --multi --height 40% --color fg:#ebdbb2,hl:#fabd2f --prompt "Select packages to exclude: " \
  --header $'----------\n(Use Tab/Shift+Tab to select multiple)\n(Press Esc to skip exclusion)\n----------' --border)

# Convert excluded packages to an array
excluded=($excluded_packages)

# Start the process
echo "Starting to $action dotfiles..."

for dir in "${packages[@]}"; do
  if [[ " ${excluded[@]} " =~ " ${dir} " ]]; then
    echo "Skipping $dir as it was excluded."
    continue
  fi

  if [[ "$action" == "stow" ]]; then
    echo "Attempting to stow $dir"
    stow $dir
    if [ $? -eq 0 ]; then
      echo "$dir stowed successfully."
    else
      echo "Error stowing $dir."
    fi
  else
    echo "Attempting to unstow $dir"
    stow -D $dir
    if [ $? -eq 0 ]; then
      echo "$dir unstowed successfully."
    else
      echo "Error unstowing $dir."
    fi
  fi
done

echo "Dotfiles have been ${action}ed successfully."
