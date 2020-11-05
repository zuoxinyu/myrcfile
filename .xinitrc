#!/bin/sh
xrdb -merge $HOME/.Xresources
# exec xmodmap $HOME/.xmodmaprc &

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS="@im=fcitx5"
# exec compton -b &
# exec fcitx &
exec i3
