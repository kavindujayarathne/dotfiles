#!/usr/bin/env bash

# Prompt for Git credentials
read -p "Enter your Git author name: " git_author_name
read -p "Enter your Git author email: " git_author_email
read -p "Enter your Git username: " gh_user

# Create the .gitconfig_local file with the provided information
cat <<EOF >~/.gitconfig_local
# Git credentials
[user]
    name = $git_author_name
    email = $git_author_email
[github]
    user = $gh_user
EOF

echo ".gitconfig_local file created."
