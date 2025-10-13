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

# Networking aliases

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
alias gd="git diff"

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
alias buu="brew update && brew upgrade"
alias bl-vm="brew list --versions --multiple"
alias bl-ior="brew list --installed-on-request"
alias bl-iad="brew list --installed-as-dependency"
alias bl-pfb="brew list --poured-from-bottle"
alias bl-bfs="brew list --built-from-source"
alias bins="brew install"
alias buins="brew uninstall"

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
# Atuin
# -----------------------------------------------------------------------------
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"

bindkey '^R' atuin-search
