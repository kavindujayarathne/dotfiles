#!/usr/bin/env bash

# Prompt for Git credentials
read -p "Enter your Git author name: " git_author_name
read -p "Enter your Git author email: " git_author_email
read -p "Enter your Git username: " gh_user

# Create the .extra file with the provided information
cat <<EOF >~/.extra
# Git credentials
export GIT_AUTHOR_NAME="$git_author_name"
export GIT_AUTHOR_EMAIL="$git_author_email"
export GIT_USER="$gh_user"
EOF

echo ".extra file created."
