# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
#这是为了解决env permison dinie 的问题
alias env='env.exe'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
alias apt-get='apt-cyg'
alias php='/cygdrive/e/www/xampp/php/php.exe'
alias linode='ssh zuoxinyu@173.255.213.18 -p 20385 -v'
alias gpush='git push origin master'
alias gcc='gcc -std=c99 -g -Wall -fdiagnostics-color=auto'
alias subl='C:/Program\ Files/Sublime\ Text\ 3/subl.exe '
alias ff='"C:/Program\ Files\ (x86)/Firefox/firefox.exe" '
alias tk='taskkill'
alias tl='tasklist'
alias fb='"D:/Programs/Players/Foobar2000/fusion/foobar2000.exe  "'
alias fbn='"D:/Programs/Players/Foobar2000/fusion/foobar2000.exe /next"'
alias fbp='"D:/Programs/Players/Foobar2000/fusion/foobar2000.exe /play"'
alias fbs='"D:/Programs/Players/Foobar2000/fusion/foobar2000.exe /pause"'
alias code='"C:/Program Files (x86)/Microsoft VS Code/Code.exe"'
#alias git='C:/Program\ Files/Git/bin/git.exe'
alias gs='git status'
alias tcc='/bin/tcc/tcc.exe'
alias nmap='D:/Programs/Develop/Nmap/nmap.exe'
alias tt='~/tt/bin/tt.exe'
alias sshubuntu='ssh zuoxinyu@192.168.0.101'
#alias vim="C:/Users/ZXY/gvim/vim.exe"
#alias vim="C:/Program\ Files/vim/vim74/vim.exe"
alias vi='vim'
set -o vi

#setopt prompt_subst
#. ~/git-prompt.sh
#export RPROMPT=$'$(__git_ps1 "%s")'

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

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#export JAVA_HOME=/home/zuoxinyu/Downloads/jdk1.8.0_65
#export JRE_HOME=${JAVA_HOME}/jre
#export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
#export PATH=${JAVA_HOME}/bin:$PATH
