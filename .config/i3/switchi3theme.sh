#!/bin/bash
LIGHT='light'
DARK='dark'
THEME_FILE=~/.config/i3/current_theme

current_mode=`cat $THEME_FILE`
cmd=$1

switch-theme() {
    mode=$1
    echo $mode > $THEME_FILE
    # TODO: pipefail rollback
    ln -sf ~/.config/rofi/themes/colors.$mode.rasi  ~/.config/rofi/themes/colors.rasi
    ln -sf ~/.config/polybar/colors.$mode.ini       ~/.config/polybar/colors.ini
    ln -sf ~/.config/dunst/dunstrc.$mode            ~/.config/dunst/dunstrc
    # write i3 config, comment old theme define and uncomment another
    sed -i -e 's/^#client/@client/' -e 's/^client/\#client/' -e 's/^@client/client/' ~/.config/i3/config

    switch-wallpaper $mode
    switch-global-theme $mode
    switch-konsole-theme $mode

    pkill dunst
    i3-msg restart
    dunst &
    notify-send "i3' 'Theme switched to $mode"
}

switch-wallpaper() {
    if [ "$1" = "$DARK" ]; then
        feh --no-fehbg --bg-fill ~/.config/i3/MrLee.jpg
    else
        feh --no-fehbg --bg-fill ~/.config/i3/Ryan.jpg
    fi
}

switch-konsole-theme() {
    if [ "$1" = "$DARK" ];then
        THEME='Gruvbox'
    else
        THEME='SolarizedLight'
    fi

    # find all openned pts by konsole
    for i in /dev/pts/*; do
        if test -c $i; then
            # see /usr/bin/konsoleprofile
            printf "\033]50;colors=$THEME\a" > $i
        fi
    done
}

switch-global-theme() {
    if [ "$1" = "$DARK" ];then
        THEME='Qogir-dark'
    else
        THEME='Qogir'
    fi

    kvantummanager --set $THEME
    gsettings set org.gnome.desktop.interface gtk-theme $THEME
    gsettings set org.gnome.desktop.interface icon-theme $THEME
}

# TODO: switch vim colorscheme
# TODO: switch chrome color

if [ "$cmd" = "toggle" ]; then
    if [ "$current_mode" = "$LIGHT" ];then
        switch-theme $DARK
    else
        switch-theme $LIGHT
    fi
elif [ "$1" = "reset" ]; then
    switch-wallpaper $current_mode
fi

