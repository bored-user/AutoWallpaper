#!/bin/bash
proc=$(ps aux | grep [A]W-Main.sh -wc)
if [ $proc -eq 0 ]; then
    while ( true );
    do
        ~/bin/AutoWallpaper/tasks/AW-Change.sh
        sleep 60
    done
fi