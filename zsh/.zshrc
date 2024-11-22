#TODO:
# fix reloadZ and editZ
# fix eval thing
# fix caffeinate -d for print message
# fix autocompletions double initialization
# fix fuzzy finder

# -----------------------------------------------------------------------------
# Interactive Shell Check - Only proceed if running interactively
# -----------------------------------------------------------------------------
case $- in
  *i*) ;;  # Interactive shell, continue loading
  *) return ;;  # Non-interactive shell, exit
esac

# -----------------------------------------------------------------------------
# Source additional configuration files
# -----------------------------------------------------------------------------
# if [ -f ~/.extra ]; then
#     source ~/.extra
# fi

# -----------------------------------------------------------------------------
# Starship (prompt customization)
# -----------------------------------------------------------------------------
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# -----------------------------------------------------------------------------
# zsh
# -----------------------------------------------------------------------------
# Initializing autocompletions
autoload -Uz compinit && compinit

# General aliases
alias reloadZ="source ~/.zshrc"
alias editZ="nvim ~/.zshrc"
alias cl="clear"
alias ..="cd .."
alias ...="cd ../.."
alias nv="nvim"
alias ll="ls -al"
alias la="ls -a"
alias caf="caffeinate -d"

# Don't ask if user is sure when running rm with wildcards
setopt rmstarsilent

# If wildcard pattern has no matches, return an empty string
setopt no_nomatch

# Functions
#TODO: In the future;
# We can add functions to performe multiple commands at once.
# Ex: 
# gquick() {
#   git add .
#   git commit -m "$1"
# }
# Usage: gquick "commit-message"

# History setup
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey '^l' autosuggest-accept
# bindkey '^e' autosuggest-execute
bindkey '^f' autosuggest-fetch
# bindkey '^u' autosuggest-toggle
bindkey '^e' vi-forward-word
# bindkey '^k' up-line-or-search
# bindkey '^j' down-line-or-search


source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Default editor
export EDITOR=/opt/homebrew/bin/nvim

# -----------------------------------------------------------------------------
# Yazi
# -----------------------------------------------------------------------------
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# -----------------------------------------------------------------------------
# Tmux (terminal multiplexer)
# -----------------------------------------------------------------------------
# aliases
alias t="tmux"
alias t-ls="tmux ls"
# alias dotfiles="tmux new -s 'testing' -c '$HOME/dotfiles'"

# -----------------------------------------------------------------------------
# Aerospace (window manager)
# -----------------------------------------------------------------------------
# aliases
alias a-la="aerospace list-apps"

# ... Git (version control) ...
# aliases
alias gint="git init"
alias gs="git status"
alias gct='git commit -m'
alias gl="git log"
alias gl-g="git log --graph"
alias ga="git add"
alias grs-s="git restore --staged"
alias gb="git branch"
alias gco-b="git checkout -b"
alias gco="git checkout"
alias gb-d="git branch -d"
alias gb-D="git branch -D" # Force delete if a branch is not fully merged
alias grm-c="git rm -r --cached"
alias gsw="git switch"
alias gsw-c="git switch -c"
alias grst-H="git reset HEAD -- "
alias grs="git restore"
alias gst="git stash"
alias gst-a="git stash apply"
alias gst-l="git stash list"
alias gst-d="git stash drop"
alias gst-c="git stash clear"
alias gcl="git clean -fd"
alias grl="git reflog"
alias grst="git reset"           # git reset <commit hash>
alias grst-s="git reset --soft"  # git reset --soft <commit hash>
alias grst-h="git reset --hard"  # git reset --hard <commit hash>
alias gmg="git merge"
alias gmg-a="git merge --abort"

# -----------------------------------------------------------------------------
# FZF (better search)
# -----------------------------------------------------------------------------
source <(fzf --zsh)

# -----------------------------------------------------------------------------
# eza (better version of ls)
# -----------------------------------------------------------------------------
# aliases
alias ls="eza --color=always --no-filesize --icons=always --no-user"
alias lt="eza -T --icons"
alias lt-a1="eza -T --icons -a --level=1"
alias lt-a2="eza -T --icons -a --level=2"
alias lt-a3="eza -T --icons -a --level=3"

# -----------------------------------------------------------------------------
# bat (better version of cat)
# -----------------------------------------------------------------------------
export BAT_THEME="catppuccin-mocha"

# aliases
alias cat="bat"

# -----------------------------------------------------------------------------
# Zoxide (better cd)
# -----------------------------------------------------------------------------
eval "$(zoxide init zsh)"

# -----------------------------------------------------------------------------
# Homebrew (package manager)
# -----------------------------------------------------------------------------
# aliases
alias bs="brew search"
alias bi="brew info"
alias bar="brew autoremove"
alias bcl="brew cleanup"
alias bcl-n="brew cleanup -n"
alias bu="brew update"
alias bug="brew upgrade"
alias bo="brew outdated"
alias buu="brew update && brew upgrade"
alias bl="brew list"
alias bl-f="brew list --formula"
alias bl-c="brew list --cask"
alias bl-v="brew list --versions"
alias bl-vm="brew list --versions --multiple"
alias bl-ior="brew list --installed-on-request"
alias bl-iad="brew list --installed-as-dependency"
alias bl-pfb="brew list --poured-from-bottle"
alias bl-bfs="brew list --built-from-source"
alias bins="brew install"
alias buins="brew uninstall"

# Env variables
if [[ ":$PATH:" != *":/opt/homebrew/opt/node@22/bin:"* ]]; then
    export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
fi

# For compilers to find node@22 you may need to set:
# export LDFLAGS="-L/opt/homebrew/opt/node@22/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/node@22/include"


# Bundle file location
export HOMEBREW_BUNDLE_FILE="$HOME/.config/brewfile/Brewfile"

# -----------------------------------------------------------------------------
# Atuin
# -----------------------------------------------------------------------------
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"

bindkey '^R' atuin-search
