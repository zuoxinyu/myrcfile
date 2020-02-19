#!/usr/bin/env python3
import dbus
import sys

try:
    bus = dbus.SessionBus()
    cloudmusic = bus.get_object("org.mpris.MediaPlayer2.netease-cloud-music", "/org/mpris/MediaPlayer2")
    props = dbus.Interface(cloudmusic, "org.freedesktop.DBus.Properties")

    metadata = props.Get("org.mpris.MediaPlayer2.Player", "Metadata")
    artist = metadata['xesam:artist'][0]
    song = metadata['xesam:title']

    if len(sys.argv) > 1:
        cmd = sys.argv[1]
        if cmd == 'play':
            cloudmusic.Play()
        elif cmd == 'pause':
            cloudmusic.Pause()
            print('paused')
        elif cmd == 'playpause':
            cloudmusic.PlayPause()
        elif cmd == 'prev':
            cloudmusic.Previous()
        elif cmd == 'next':
            cloudmusic.Next()
        else:
            exit()

    if len(song) > 30:
        song = song[0:30]
        song += '...'
        if ('(' in song) and (')' not in song):
            song += ')'

    output = song + ' - ' + artist
    print(output)

except:
    print("")
