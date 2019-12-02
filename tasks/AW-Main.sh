#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $dir
cd ../
source settings.conf
proc=$(ps aux | grep [A]W-Main -wc)
if [ $proc -eq 2 ]; then # Making sure a new instance isn't started. If this happens, there will be several files changing wallpaper every minute.
    if [ $notification_new_instances = "true" ] && [ $notification = "true" ]; then
        notify-send --icon="$dir/img/favico.png" "AutoWallpaper" "New instance started." # Notify
    fi
    if [ $log_new_instances = "true" ] && [ $log = "true" ]; then
        tasks/AW-Log.sh "New instance started" # Logging
    fi
    while ( true ); do
        tasks/AW-Change.sh # Execute change
        sleep $sleep_time
    done
else
    if [ $notification_new_instances_fail = "true" ] && [ $notification = "true" ]; then
        notify-send --icon="$dir/img/favico.png" "AutoWallpaper" "Script already running!" # Notify
    fi
fi