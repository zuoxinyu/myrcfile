#这是为了解决启动时的permission denied 的问题
alias env='/bin/env.exe'
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
ZSH_THEME="tonotdo"

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
plugins=(git)
#(zsh-syntax-highlighting)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/cygdrive/c/Windows/System32"
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

#source /home/ZXY/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#这是为了解决env permison dinie 的问题
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
alias linode='ssh zuoxinyu@173.255.213.18 -p 20385 -v'
alias gpush='git push origin master'
alias gcc='gcc -std=c99 -g -Wall -fdiagnostics-color=auto'
alias subl='C:/Program\ Files/Sublime\ Text\ 3/subl.exe '
alias ff='"C:/Program\ Files\ (x86)/Firefox/firefox.exe" '
#alias git='C:/Program\ Files/Git/bin/git.exe'
alias gs='git status'
alias tcc='/bin/tcc/tcc.exe'
alias nmap='D:/Programs/Develop/Nmap/nmap.exe'
alias tt='~/tt/bin/tt.exe'
alias sshubuntu='ssh zuoxinyu@192.168.0.101'
#alias vim="C:/Users/ZXY/gvim/vim.exe"
#alias vim="C:/Program\ Files/vim/vim74/vim.exe"
alias vi='vim'
alias htdocs='cd /cygdrive/e/www/xampp/htdocs'
#alias php='/cygdrive/e/www/xampp/php/php.exe'
#alias composer='php /usr/local/bin/composer.phar'
alias apt-get='apt-cyg'
alias t=tree

autoload -U compinit
compinit

#setopt prompt_subst
#. ~/git-prompt.sh
#export RPROMPT=$'$(__git_ps1 "%s")'

#setopt completealiases
setopt HIST_IGNORE_DUPS
bindkey -v

#curl mimosa-pudica.net/src/incr-0.2.zsh　>> ~/.oh-my-zsh/plugins/incr/incr.zsh && source .zshrc
#source ~/.oh-my-zsh/plugins/incr/incr.zsh
#prompt=%{$fg_no_bold[cyan]%}%n%{$fg_no_bold[magenta]%}::%{$fg_no_bold[green]%}%3~$(git_prompt_info)%{$reset_color%}»
export PATH=/cygdrive/e/www/xampp/apache/bin:/cygdrive/e/www/xampp/php:/cygdrive/e/www/xampp/mysql/bin/:/cygdrive/c/Program\ Files/nodejs:/cygdrive/c/Program\ Files/Haskell\ Platform/7.10.3/bin:/cygdrive/c/ProgramData/ComposerSetup/bin:/cygdrive/c/Users/ZXY/AppData/Roaming/Composer/vendor/bin:$PATH
alias gcam='git commit -am'
