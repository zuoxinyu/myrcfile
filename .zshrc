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
alias findf='find . -name'
alias cnpm="npm --registry=https://registry.npm.taobao.org \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npm.taobao.org/dist \
  --userconfig=$HOME/.cnpmrc"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#ZSH_THEME="agnoster"
ZSH_THEME="norm"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
plugins=(git z rust vi-mode fzf zsh-autosuggestions zsh-syntax-highlighting) 
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

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

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

#eval $(thefuck --alias)
if [[ -f /bin/most ]]; then
    alias man='PAGER=most man'
    alias cat='PAGER=less bat'
fi

if [[ -f ~/.zshrc_spec_machine ]]; then
    source ~/.zshrc_spec_machine
fi


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
