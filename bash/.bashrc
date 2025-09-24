# -----------------------------------------------------------------------------
# Interactive Shell Check - Only proceed if running interactively
# -----------------------------------------------------------------------------
case $- in
*i*) ;;
*) return ;;
esac

set -o vi

# ... Starship ...
eval "$(starship init bash)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# aliases
alias cl="clear"
alias reload-bash="source ~/.bashrc"
alias edit-bash="nvim ~/.bashrc"

# ... FZF ...
eval "$(fzf --bash)"

# ... eza (better version of ls) ...
# aliases
alias ls="eza --color=always --no-filesize --icons=always --no-user"
alias lt="eza -T --icons"
alias lt-a1="eza -T --icons -a --level=1"
alias lt-a2="eza -T --icons -a --level=2"
alias lt-a3="eza -T --icons -a --level=3"

# ... Zoxide (better cd) ...
eval "$(zoxide init bash)"

# Env variables
export EDITOR="nvim"
# Bundle file location
export HOMEBREW_BUNDLE_FILE="$HOME/dotfiles/config/.config/brewfile/Brewfile"
