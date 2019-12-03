#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $dir
cd ../
source settings.conf
proc=$(ps aux | grep [A]W-Main -wc)
if [ $proc -eq 2 ]; then # Making sure a new instance isn't started. If this happens, there will be several files changing wallpaper every minute.
    if [ $notification_new_instances = "true" ] && [ $notification = "true" ]; then
        if [ -f img/favico ]; then
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "New instance started." # Notify
        else
            tasks/AW-Image.sh
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "New instance started." # Notify
        fi
    fi
    if [ $log_new_instances = "true" ] && [ $log = "true" ]; then
        tasks/AW-Log.sh "New instance started" # Logging
    fi
    while ( true ); do
        tasks/AW-Change.sh # Execute change
        if [ $sleep_time = "" ]; then
            if [ -f img/favico ]; then
                notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Sleep time variable is unset. Please set it on settings.conf file (this isn't a fatal error. Using '60' as the sleep time.)" # Notify
            else
                tasks/AW-Image.sh
                notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Sleep time variable is unset. Please set it on settings.conf file (this isn't a fatal error. Using '60' as the sleep time.)" # Notify
            fi
            sleep 60
        else
            sleep $sleep_time
        fi
    done
else
    if [ $notification_new_instances_fail = "true" ] && [ $notification = "true" ]; then
        if [ -f img/favico ]; then
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Script already running!" # Notify
        else
            tasks/AW-Image.sh
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Script already running!" # Notify
        fi
    fi
fi