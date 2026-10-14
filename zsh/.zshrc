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
# macOS: BSD ls
export LSCOLORS="Gxfxcxdxbxexexaxaxaxaxaxa"

# GNU-style colors for compatible tools, including tree
# export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

alias ls='ls -G'
alias grep='grep -G'
alias fgrep='fgrep -G'
alias egrep='egrep -E'

elif [[ "$OSTYPE" == linux* ]]; then
# Linux: GNU-style colors
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'

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
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --bind 'ctrl-u:preview-page-up,ctrl-d:preview-page-down'"

    export FZF_DEFAULT_OPTS="
    --color=fg:#DCD7BA,bg:-1,fg+:#DCD7BA,bg+:-1
    --color=hl:#7FB4CA,hl+:#7FB4CA
    --color=pointer:#957FB8,marker:#E6C384
    --color=prompt:#7E9CD8,info:#727169
    --color=border:#54546D"

    export FZF_CTRL_R_OPTS="
    --style full
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --bind 'ctrl-u:preview-page-up,ctrl-d:preview-page-down'"
fi

# bat

if command -v bat >/dev/null 2>&1; then
    export BAT_THEME="Kanagawa"
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
alias ll='ls -l'
alias lla='ls -la'
alias la='ls -a'
alias l='ls'
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
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

#Tree
alias tree='command tree -C'

# Starship

export STARSHIP_CONFIG="$CONFIG_DIR/starship/starship.toml"

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
