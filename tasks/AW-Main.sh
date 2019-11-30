#!/bin/bash
proc=$(ps aux | grep [A]W-Main -wc)
if [ $proc -eq 2 ]; then # making sure a new instance isn't started. if this happens, there will be several files changing wallpaper every minute.
    notify-send --icon="/home/$USER/bin/AutoWallpaper/img/favico.png" "AutoWallpaper" "New instance started." # notify
    /home/$USER/bin/AutoWallpaper/tasks/AW-Log.sh "New instance started"
    while ( true ); do
        /home/$USER/bin/AutoWallpaper/tasks/AW-Change.sh
        sleep 60
    done
fi