set wshshell = createobject("wscript.shell")
wshshell.run "cmd /c start .Manjaro.xlaunch & bash -c 'DISPLAY=:0 LC_CTYPE=zh_CN.UTF-8 LANG=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8 GTK_IM_MODULE=fcitx QT_IM_MODULE=fcitx XMODIFIERS=@im=fcitx i3'",0
