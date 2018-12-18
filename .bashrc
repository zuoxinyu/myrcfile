# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export DISPLAY=:0
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias gpush='git push'
alias gcc='gcc -std=c11 -Wall -fdiagnostics-color=auto'
alias gs='git status'
alias vi='vim'
alias t=tree
alias gcam='git commit -am'
alias gpush='git push'
#export PAGER=most
export EDITOR=vim

alias php=php56
