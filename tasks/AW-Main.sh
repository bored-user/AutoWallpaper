#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # Get current path (where this script is being executed)
cd $dir # Change directory to it
cd ../ # Go one directory up (in order to get to project root)
source settings.conf # Import settings.conf
proc=$(ps aux | grep [A]W-Main -wc) # Filter proc list, searching "AW-Main". The -wc flag makes it return an integer
if [ $proc -eq 2 ]; then # Making sure a new instance isn't started. If this happens, there will be several files changing wallpaper every minute.
    tasks/AW-Notification.sh "New instance started." "notification_new_instances"
    if [ $log_new_instances = "true" ] && [ $log = "true" ]; then # If logging AND new instances options are true
        tasks/AW-Log.sh "New instance started" # Logging
    fi
    while ( true ); do # Loop
        tasks/AW-Change.sh # Execute change task
        if [ -z ${wallpaper_change_interval_time+x} ]; then # If sleep time isn't set
            tasks/AW-Notification.sh "Sleep time variable (wallpaper_change_interval_time) is unset. Please set it on settings.conf file (this isn't a fatal error. Using '60' as the sleep time.)" 0 "urgent"
            sleep 60 # Default sleep time. Will only be executed if the previous variable isn't set
        else
            if [ $wallpaper_change_interval_unit = "sec" ]; then
                sleep $wallpaper_change_interval_time # Sleep value set by user on settings.conf
            elif [ $wallpaper_change_interval_unit = "min" ]; then
                let wallpaper_change_interval_time=$wallpaper_change_interval_time*60 # Minute to second
                sleep $wallpaper_change_interval_time # Sleep
            else
                ./AW-Crontab.sh $wallpaper_change_interval_time $PWD # Unit will either be "reboot" or "day"
            fi
        fi
    done
else
    tasks/AW-Notification.sh "Script already running!" "notification_new_instances_fail"
fi