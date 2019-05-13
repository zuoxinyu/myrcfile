#!/bin/sh
exec compton -b &
exec fcitx &
exec xmodmap ~/.xmodmaprc
exec i3
