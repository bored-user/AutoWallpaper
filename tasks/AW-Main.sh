#!/bin/bash
proc=$(ps aux | grep [A]W-Main -wc)
if [ $proc -eq 2 ]; then # making sure a new instance isn't started. if this happens, there will be several files changing wallpaper every minute.
    while ( true );
    do
        ~/bin/AutoWallpaper/tasks/AW-Change.sh
        sleep 60
    done
fi