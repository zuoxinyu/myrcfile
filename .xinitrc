#!/bin/sh
xrdb -merge ~/.Xresources
exec compton -b &
exec fcitx &
exec xmodmap ~/.xmodmaprc
exec i3
