## Oh-my-zsh
export ZSH=~/.oh-my-zsh
HYPHEN_INSENSITIVE="true"

plugins=(\
    git\
    colored-man-pages\
    npm\
    pip\
    docker\
    z\
    rust\
    vi-mode\
    fzf\
    zsh_reload\
    zsh-autosuggestions\
    #fast-syntax-highlighting\
    #zsh-syntax-highlighting\
    # slow on newest wsl2
)

# some completion options
autoload -U compinit
compinit
autoload -U promptinit
promptinit
zstyle ':completion:*' menu select

setopt completealiases
setopt HIST_IGNORE_DUPS

# enable vim keybindings
bindkey -v

set bell-style none

source $ZSH/oh-my-zsh.sh

## Environments
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vi

export GOPATH=$HOME/go
export CARGO_HOME=$HOME/.cargo
export VCPKG_ROOT=$HOME/.vcpkg

export PATH=$PATH:\
$HOME/.local/bin/:\
$HOME/.yarn/bin:\
$HOME/.config/yarn/global/node_modules/.bin:\
$CARGO_HOME/bin:\
$GOPATH/bin:\
$HOME/depot_tools:

## Aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias lt='ll --sort=time'
alias vi='vim'
alias gcam='git commit -am'
alias gpush='git push'
alias gs='git status'
alias t=tree
alias findf='find . -name'
alias path='echo $PATH | sed s/:/\\n/g'

## Alternative commands
if [ -x `command -v most` ]; then
    export PAGER=most
    alias man='PAGER=most man'
fi

if [ -x `command -v nvim` ]; then
    alias vim=nvim
    alias vi=nvim
    export EDITOR=nvim
fi

if [ -x `command -v lsd` ]; then
    alias ls=lsd
    alias ll='lsd -l'
    alias la='lsd -al'
fi

## WSL
if [[ -n $WSLENV ]]; then
    if [[ -n $WSL2_GUI_APPS_ENABLED ]]; then
    else
        export WinHost=`cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }'`
        if [ ! -n "$(grep -P "[[:space:]]WinHost" /etc/hosts)" ]; then
            printf "%s\t%s\n" "$WinHost" "WinHost" | sudo tee -a "/etc/hosts"
        fi
        export DISPLAY=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`:0
        export LIBGL_ALWAYS_INDIRECT=1
        export PULSE_SERVER=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`
    fi
fi

## Appearance
if [ -x `command -v starship` ]; then
    eval `starship init zsh`
elif [ -x `command -v p10k` ]; then
    ZSH_THEME="powerlevel10k/powerlevel10k"
else
    ZSH_THEME="agnoster"
fi

## Custom per machine
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

