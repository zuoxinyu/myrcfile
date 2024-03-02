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
    zsh-autosuggestions\
    #zsh_reload\
    #fast-syntax-highlighting\
    zsh-syntax-highlighting\
    # slow on newest wsl2
)

# some completion options
autoload -U compinit
compinit
autoload -U promptinit
promptinit
zstyle ':completion:*' menu select

autoload bashcompinit
bashcompinit

setopt completealiases
setopt HIST_IGNORE_DUPS

# enable vim keybindings
# bindkey -v

set bell-style none

## Environments
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vi

export GOPATH=$HOME/go
export CARGO_HOME=$HOME/.cargo
export VCPKG_ROOT=$HOME/.vcpkg
export CMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake
export VCPKG_DEFAULT_TRIPLET=x64-linux

export PATH=$PATH:\
$HOME/.local/bin/:\
$HOME/.yarn/bin:\
$HOME/.config/yarn/global/node_modules/.bin:\
$CARGO_HOME/bin:\
$VCPKG_ROOT:\
$GOPATH/bin:
# $HOME/depot_tools:

## Aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias vi='vim'
alias gcam='git commit -am'
alias gpush='git push'
alias gs='git status'
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

if [ -x `command -v exa` ]; then
    alias ls='exa --icons'
    alias ll='exa --icons -l'
    alias la='exa --icons -al'
elif [ -x `command -v lsd`]; then
    alias ls='lsd'
    alias ll='lsd -l'
    alias la='lsd -al'
else
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias lt='ll --sort=time'
fi

## WSL
wslg_dpi_scale() {
    local dpi_scale WindowMetricsAppliedDPI
    dpi_scale="${GDK_DPI_SCALE:-${QT_SCALE_FACTOR:-}}"
    if [[ -z "${dpi_scale:-}" ]] ; then
        WindowMetricsAppliedDPI=$("/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" "(Get-ItemProperty -Path 'HKCU:\\Control Panel\\Desktop\\WindowMetrics').AppliedDPI")
        WindowMetricsAppliedDPI=${WindowMetricsAppliedDPI%$'\r'}
        dpi_scale=$(bc <<<"scale=2; $WindowMetricsAppliedDPI / 96")
    fi

    export GDK_DPI_SCALE=${GDK_DPI_SCALE:-$dpi_scale}
    export GTK_SCALE=${GTK_SCALE:-$dpi_scale}

    # https://doc.qt.io/qt-5/highdpi.html
    # export QT_AUTO_SCREEN_SCALE_FACTOR=${QT_AUTO_SCREEN_SCALE_FACTOR:-1}
    # export QT_ENABLE_HIGHDPI_SCALING=${QT_ENABLE_HIGHDPI_SCALING:-1}
    export QT_SCALE_FACTOR=${QT_SCALE_FACTOR:-$GDK_DPI_SCALE}

    # export MESA_D3D12_DEFAULT_ADAPTER_NAME="Intel(R) UHD Graphics 770"
}

if [[ -n $WSLENV ]]; then
    if [[ -n $WSL2_GUI_APPS_ENABLED ]]; then
        export LIBVA_DRIVER_NAME=d3d12
        [ -d /mnt/wslg/runtime-dir ] && wslg_dpi_scale
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

source $ZSH/oh-my-zsh.sh

## Appearance
if [ -x `command -v starship` ]; then
    eval "$(starship init zsh)"
else
    ZSH_THEME="agnoster"
fi

## Custom per machine
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

test -f "$HOME/.xmake/profile" && source "$HOME/.xmake/profile"
test -f "$VCPKG_ROOT" && source $VCPKG_ROOT/scripts/vcpkg_completion.zsh
