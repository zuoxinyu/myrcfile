#!/bin/sh
xrdb -merge $HOME/.Xresources
# exec xmodmap $HOME/.xmodmaprc &
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
# exec compton -b &
# exec fcitx &
exec i3
