# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
# Common environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim

export less=-r
export less_termcap_mb=$'\e[1;31m'     # begin bold
export less_termcap_md=$'\e[1;36m'     # begin blink
export less_termcap_me=$'\e[0m'        # reset bold/blink
export less_termcap_so=$'\e[01;44;33m' # begin reverse video
export less_termcap_se=$'\e[0m'        # reset reverse video
export less_termcap_us=$'\e[1;32m'     # begin underline
export less_termcap_ue=$'\e[0m'        # reset underline

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias lt='ll --sort=time'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias vi='vim'
alias gcam='git commit -am'
alias gpush='git push'
alias gs='git status'
alias t=tree
alias cnpm="npm --registry=https://registry.npm.taobao.org \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npm.taobao.org/dist \
  --userconfig=$HOME/.cnpmrc"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

ZSH_THEME="agnoster"
#ZSH_THEME="norm"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
#, zsh-syntax-highlighting)

# User configuration

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# some completion options
autoload -U compinit
compinit
autoload -U promptinit
promptinit
zstyle ':completion:*' menu select

#setopt prompt_subst
#. ~/git-prompt.sh
#export RPROMPT=$'$(__git_ps1 "%s")'
#
setopt completealiases
setopt HIST_IGNORE_DUPS

# enable vim keybindings
bindkey -v

#curl mimosa-pudica.net/src/incr-0.2.zsh　>> ~/.oh-my-zsh/plugins/incr/incr.zsh && source .zshrc
#source ~/.oh-my-zsh/plugins/incr/incr.zsh

# improve man style
function man() {
	less_termcap_md=$'\e[01;31m' \
    less_termcap_me=$'\e[0m' \
    less_termcap_se=$'\e[0m' \
    less_termcap_so=$'\e[01;44;33m' \
    less_termcap_ue=$'\e[0m' \
    less_termcap_us=$'\e[01;32m' \
    command man "$@"
}

RPROMPT='%{$fg[green]%}${VIMODE}%{$reset_color%}'
#source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#eval $(thefuck --alias)
if [[ -f /bin/most ]]; then
    alias man='PAGER=most man'
    alias cat='PAGER=less bat'
fi

#alias for npm
if [[ -f ~/.zshrc_spec_machine ]]; then
    source .zshrc_spec_machine
fi
