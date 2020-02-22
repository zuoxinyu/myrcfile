#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# mpd ~/.config/mpd/mpd.conf &

# Launch bar1 and bar2
polybar main &
polybar second &
# polybar tray &

echo "Bars launched..."
