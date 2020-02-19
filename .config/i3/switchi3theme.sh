#!/bin/bash
LIGHT='light'
DARK='dark'
THEME_FILE=~/.config/i3/current_theme

current=`cat ${THEME_FILE}`

if [ "$current" = "$DARK" ];then
    ln -sf ~/.config/polybar/colors.light.ini ~/.config/polybar/colors.ini
    ln -sf ~/.config/dunst/dunstrc.light ~/.config/dunst/dunstrc
    ln -sf ~/.config/rofi/themes/colors.light.rasi ~/.config/rofi/themes/colors.rasi
    sed -i -e 's/^#client/@client/' -e 's/^client/\#client/' -e 's/^@client/client/' ~/.config/i3/config
    echo $LIGHT > $THEME_FILE
    feh --no-fehbg --bg-fill ~/.config/i3/Ryan.jpg
else
    ln -sf ~/.config/polybar/colors.dark.ini ~/.config/polybar/colors.ini
    ln -sf ~/.config/dunst/dunstrc.dark ~/.config/dunst/dunstrc
    ln -sf ~/.config/rofi/themes/colors.dark.rasi ~/.config/rofi/themes/colors.rasi
    sed -i -e 's/^#client/@client/' -e 's/^client/\#client/' -e 's/^@client/client/' ~/.config/i3/config
    feh --no-fehbg --bg-fill ~/.config/i3/MrLee.jpg
    echo $DARK > $THEME_FILE
fi

pkill dunst
i3-msg restart
dunst &

