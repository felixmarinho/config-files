# Oh My Zsh

export ZSH="$HOME/.oh-my-zsh"

# Don't exit shell with Ctrl-D
setopt ignoreeof

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
 #  fast-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"


# Environment

export EDITOR="nvim"

# Shared config directory
export CONFIG_DIR="$HOME/.config-files"

# OS-specific configuration

if [[ "$OSTYPE" == darwin* ]]; then

    # macOS
    export LSCOLORS="Gxfxcxdxbxexexaxaxaxaxaxa"
    export EZA_COLORS='di=34:ln=36:pi=33:so=35:bd=36:cd=36:ex=32'

    alias ls='eza --color=auto'
    alias grep='grep -G'
    alias fgrep='fgrep -G'
    alias egrep='egrep -F'

elif [[ "$OSTYPE" == linux* ]]; then

    # Linux
    export EZA_COLORS='di=34:ln=36:pi=33:so=35:bd=36:cd=36:ex=32'

    alias ls='eza --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

fi

# PATH

# User binaries
export PATH="$HOME/.local/bin:$PATH"

#LM Studio CLI
if [[ -d "$HOME/.lmstudio/bin" ]]; then
    export PATH="$HOME/.lmstudio/bin:$PATH"
fi


# Development Tools

# zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi


# fzf

if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)

    export FZF_CTRL_T_OPTS="
    --style full
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
fi


# Custom Aliases

# Zsh
alias szrc="source ~/.zshrc"
alias zrc="nvim ~/.zshrc"

# Navigation
alias desk="cd ~/Desktop"
alias dev="cd ~/DEV"
alias cff="~/.config-files"

alias cc="cd -"
alias c1="cd ~1"
alias c2="cd ~2"
alias ..='cd ..'
alias ...='cd ../..'

# General
alias ll='eza -l'
alias lla='eza -la'
alias la='eza -a'
alias l='eza'
alias c="clear"
alias cod="code ."
alias his="history"
alias echop="echo $PATH | tr ':' '\n' | nl"

# Git
alias gs="git status"
alias gss="git status -s"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias glo="git --no-pager log --oneline --reverse"

# Tmux
alias tma="tmux attach"
alias tmd="tmux detach"
alias tmls="tmux ls"
alias tmns="tmux new -s"
alias tmks="tmux kill-session"

# Docker
alias dps="docker ps"
alias din="docker inspect"

#Nvim
alias vi="nvim"


# Starship

export STARSHIP_CONFIG="$CONFIG_DIR/starship/starship.toml"

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
