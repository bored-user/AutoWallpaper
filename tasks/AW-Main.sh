#!/bin/bash
proc=$(ps aux | grep [A]W-Main -wc)
if [ $proc -eq 2 ]; then
    while ( true );
    do
        ~/bin/AutoWallpaper/tasks/AW-Change.sh
        sleep 60
    done
fi