#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # Get current path (where this script is being executed)
cd $dir # Change directory to it
cd ../ # Go one directory up (in order to get to project root)
source settings.conf # Import settings.conf
proc=$(ps aux | grep [A]W-Main -wc) # Filter proc list, searching "AW-Main". The -wc flag makes it return an integer
if [ $proc -eq 2 ]; then # Making sure a new instance isn't started. If this happens, there will be several files changing wallpaper every minute.
    if [ $notification_new_instances = "true" ] && [ $notification = "true" ]; then # If new instances and notification options are enabled
        if [ -f img/favico ]; then # If file exist
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "New instance started." # Notify
        else # If file doesn't exist
            tasks/AW-Image.sh # Download the file
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "New instance started." # Notify
        fi
    fi
    if [ $log_new_instances = "true" ] && [ $log = "true" ]; then # If logging AND new instances options are true
        tasks/AW-Log.sh "New instance started" # Logging
    fi
    while ( true ); do # Loop
        tasks/AW-Change.sh # Execute change
        if [ $sleep_time = "" ]; then # If sleep time isn't set
            if [ -f img/favico ]; then # If file exist
                notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Sleep time variable is unset. Please set it on settings.conf file (this isn't a fatal error. Using '60' as the sleep time.)" # Notify
            else
                tasks/AW-Image.sh # Download the file
                notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Sleep time variable is unset. Please set it on settings.conf file (this isn't a fatal error. Using '60' as the sleep time.)" # Notify
            fi
            sleep 60 # Default sleep time. Will only be executed if the previous variable isn't set
        else
            sleep $sleep_time # Sleep value set by user on settings.conf
        fi
    done
else
    if [ $notification_new_instances_fail = "true" ] && [ $notification = "true" ]; then # If new instance fail AND notification options are true
        if [ -f img/favico ]; then # If file exist
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Script already running!" # Notify
        else
            tasks/AW-Image.sh # Download the file
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Script already running!" # Notify
        fi
    fi
fi