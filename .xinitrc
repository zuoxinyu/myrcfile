#!/bin/sh
xrdb -merge $HOME/.Xresources
# exec xmodmap $HOME/.xmodmaprc &
exec compton -b &
exec fcitx5 &
exec i3
