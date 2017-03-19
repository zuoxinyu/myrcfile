# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

_red='\033[0;31m'          # 红色
_RED='\033[1;31m'
_green='\033[0;32m'        # 绿色
_GREEN='\033[1;32m'
_yellow='\033[0;33m'       # 黄色
_YELLOW='\033[1;33m'
_blue='\033[0;34m'         # 蓝色
_BLUE='\033[1;34m'
_purple='\033[0;35m'       # 紫色
_PURPLE='\033[1;35m'
_cyan='\033[0;36m'         # 蓝绿色
_CYAN='\033[1;36m'
_WHITE='\033[1;37m'        # 白色
_O_C='\033[0m' # 没有颜色

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
#ZSH_THEME="ys"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

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
plugins=(git,thefuck,zsh-syntax-highlighting)
#, zsh-syntax-highlighting)

# User configuration

#export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/cygdrive/c/Windows/System32"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='mvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

source /home/doubleleft/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
alias linode='ssh zuoxinyu@173.255.213.18 -p 20385 -v'
alias gpush='git push origin master'
alias gcc='gcc -std=c11 -Wall -fdiagnostics-color=auto'
alias gs='git status'
alias vi='vim'
alias htdocs='cd /cygdrive/e/www/xampp/htdocs'
alias t=tree

autoload -U compinit
compinit
autoload -U promptinit
promptinit
zstyle ':completion:*' menu select

#setopt prompt_subst
#. ~/git-prompt.sh
#export RPROMPT=$'$(__git_ps1 "%s")'

setopt completealiases
setopt HIST_IGNORE_DUPS
bindkey -v

#curl mimosa-pudica.net/src/incr-0.2.zsh　>> ~/.oh-my-zsh/plugins/incr/incr.zsh && source .zshrc
#source ~/.oh-my-zsh/plugins/incr/incr.zsh
#prompt=%{$fg_no_bold[cyan]%}%n%{$fg_no_bold[magenta]%}::%{$fg_no_bold[green]%}%3~$(git_prompt_info)%{$reset_color%}»
#export PATH=/cygdrive/e/www/xampp/apache/bin:/cygdrive/e/www/xampp/php:/cygdrive/e/www/xampp/mysql/bin/:$PATH
alias lt='ll --sort=time'

export less=-r
export less_termcap_mb=$'\e[1;31m'     # begin bold
export less_termcap_md=$'\e[1;36m'     # begin blink
export less_termcap_me=$'\e[0m'        # reset bold/blink
export less_termcap_so=$'\e[01;44;33m' # begin reverse video
export less_termcap_se=$'\e[0m'        # reset reverse video
export less_termcap_us=$'\e[1;32m'     # begin underline
export less_termcap_ue=$'\e[0m'        # reset underline
man() {
	less_termcap_md=$'\e[01;31m' \
		less_termcap_me=$'\e[0m' \
		less_termcap_se=$'\e[0m' \
		less_termcap_so=$'\e[01;44;33m' \
		less_termcap_ue=$'\e[0m' \
		less_termcap_us=$'\e[01;32m' \
		command man "$@"
}
#RPROMPT='%{$fg[green]%}${VIMODE}%{$reset_color%}'
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval $(thefuck --alias)
alias gcam='git commit -am'
alias gpush='git push'
alias cling=/home/doubleleft/Downloads/archive/cling_2016-12-15_fedora24/bin/cling
