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
# .env
# -----------------------------------------------------------------------------
export $(grep -v '^#' ~/.env | xargs)

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

alias ip="curl ifconfig.me -4; echo"
alias ip-all="curl ifconfig.me/all"

# General aliases
alias cl="clear"
alias ..="cd .."
alias ...="cd ../.."
alias nv="nvim"
alias ll="ls -al"
alias la="ls -a"
alias caf="caffeinate -d"
alias browser="~/dotfiles/scripts/ephemeral-sesh-manager.sh"
alias rm="rm -I"

# Functions
function nvs() {
  local config=$(fd --max-depth 1 --type d --glob 'nvim-*' ~/.config | xargs -n 1 basename | \
    fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)

  [[ -z $config ]] && echo "No config selected" && return

  NVIM_APPNAME=$config nvim "$@"
}

# Don't ask if user is sure when running rm with wildcards
# setopt rmstarsilent
# If wildcard pattern has no matches, return an empty string
setopt no_nomatch

# History setup
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# truncate file + start a fresh history session
alias hist-purge=': > "$HISTFILE"; fc -p; echo "zsh history cleared (restart tab for best effect)"'

# unset HISTFILE
# export HISTSIZE=5000
# export SAVEHIST=0

# Plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -e
bindkey '^l' autosuggest-accept
bindkey '^f' autosuggest-fetch
bindkey '^e' vi-forward-word
# bindkey '^k' up-line-or-search
# bindkey '^j' down-line-or-search
# bindkey '^e' autosuggest-execute
# bindkey '^u' autosuggest-toggle

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
# alias dotfiles="tmux new -s 'testing' -c '$HOME/dotfiles'"

# -----------------------------------------------------------------------------
# Aerospace (window manager)
# -----------------------------------------------------------------------------
# aliases

# -----------------------------------------------------------------------------
# Git (version control)
# -----------------------------------------------------------------------------
# aliases
alias gint="git init"
alias gs="git status"
alias ga="git add"
alias gaa="git add all"
alias gct="git commit -m"
alias gp="git push"
alias gpfl!="git push --force-with-lease"
alias gl="git log"
alias glo="git log --oneline"
alias glg="git log --graph"

# functions
function acp() {
  git add .
  git commit -m "$1"
  git push
}

# -----------------------------------------------------------------------------
# FZF (better search)
# -----------------------------------------------------------------------------
source <(fzf --zsh)

# -----------------------------------------------------------------------------
# eza (better version of ls)
# -----------------------------------------------------------------------------
# aliases
alias ls="eza --color=always --no-filesize --group --icons=always"
alias lt="eza -T --icons"
alias lt-a1="eza -T --icons -a --level=1"
alias lt-a2="eza -T --icons -a --level=2"
alias lt-a3="eza -T --icons -a --level=3"

# -----------------------------------------------------------------------------
# bat (better version of cat)
# -----------------------------------------------------------------------------
# export BAT_THEME="catppuccin-mocha"

# aliases
alias cat="bat"

# -----------------------------------------------------------------------------
# Zoxide (better cd)
# -----------------------------------------------------------------------------
eval "$(zoxide init zsh)"
alias cd="z"

# -----------------------------------------------------------------------------
# Homebrew (package manager)
# -----------------------------------------------------------------------------
# aliases
alias bcl="brew cleanup -s"
alias buu="brew update && brew upgrade"
alias bl-ior="brew list --installed-on-request"
alias bl-iad="brew list --installed-as-dependency"
alias bl-pfb="brew list --poured-from-bottle"
alias bl-bfs="brew list --built-from-source"

# Bundle file location
export HOMEBREW_BUNDLE_FILE="$HOME/.config/brewfile/Brewfile"

# keg-only utils
typeset -U path PATH

prepend_paths=(
  /opt/homebrew/opt/curl/bin
  /opt/homebrew/opt/sqlite/bin
  # add as many as you want
)

path=($prepend_paths $path)

# -----------------------------------------------------------------------------
# television
# -----------------------------------------------------------------------------
eval "$(tv init zsh)"

# -----------------------------------------------------------------------------
# Atuin
# -----------------------------------------------------------------------------
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"

bindkey '^R' atuin-search


# -----------------------------------------------------------------------------
# macpak
# -----------------------------------------------------------------------------
alias search="macpak search"
alias list="macpak list"
alias zap="macpak zap"
alias doctor="macpak doctor"
alias refresh="macpak cache-refresh"
