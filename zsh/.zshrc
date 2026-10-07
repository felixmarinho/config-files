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
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --preview-window=right,60%
    --bind 'ctrl-u:preview-page-up,ctrl-d:preview-page-down'
    --height 90%"

    export FZF_DEFAULT_OPTS="
    --layout=reverse
    --border
    --color=fg:#ABB2BF,bg:#272A31,fg+:#ABB2BF,bg+:#3E4451
    --color=hl:#61AFEF,hl+:#61AFEF
    --color=pointer:#C678DD,marker:#E5C07B
    --color=prompt:#98C379,info:#5C6370
    --color=border:#4B5263"
fi


#   --layout=reverse
#   --border
#   --color=fg:#DCD7BA,bg:#1F1F28,fg+:#DCD7BA,bg+:#2D4F67
#   --color=hl:#7FB4CA,hl+:#7FB4CA
#   --color=pointer:#957FB8,marker:#E6C384
#   --color=prompt:#7E9CD8,info:#727169
#   --color=border:#54546D"

# bat

if command -v bat >/dev/null 2>&1; then
    export BAT_THEME="OneHalfDark"
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
alias v="nvim"
alias vi="nvim"
alias vim="nvim"


# Starship

export STARSHIP_CONFIG="$CONFIG_DIR/starship/starship.toml"

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
