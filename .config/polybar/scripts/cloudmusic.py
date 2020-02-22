#!/usr/bin/env python3
import dbus
import sys
import os
import time

def getApp():
    bus = dbus.SessionBus()
    cloudmusic = bus.get_object("org.mpris.MediaPlayer2.netease-cloud-music", "/org/mpris/MediaPlayer2")
    return cloudmusic

def getMeta(app):
    try:
        props = dbus.Interface(app, "org.freedesktop.DBus.Properties")
        metadata = props.Get("org.mpris.MediaPlayer2.Player", "Metadata")
        artist = metadata['xesam:artist'][0]
        song = metadata['xesam:title']
        if len(song) > 30:
            song = song[0:30]
            song += '...'
            if ('(' in song) and (')' not in song):
                song += ')'

        output = song + ' - ' + artist

        return output
    except:
        return ''

def notify(action):
    time.sleep(0.5)
    app = getApp()
    msg = getMeta(app)
    os.system('notify-send "{}" "{}"'.format(action, msg))

app = getApp()
output = getMeta(app)

if len(sys.argv) > 1:
    cmd = sys.argv[1]
    if cmd == 'play':
        app.Play()
        notify('Playing')
    elif cmd == 'pause':
        app.Pause()
        notify('Stopped')
    elif cmd == 'playpause':
        app.PlayPause()
        notify('Playing/Paused')
    elif cmd == 'prev':
        app.Previous()
        notify('Prev')
    elif cmd == 'next':
        app.Next()
        notify('Next')
    else:
        exit()

print(output)

