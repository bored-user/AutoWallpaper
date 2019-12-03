#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # Get current path (where this script is being executed)
cd $dir # Change directory to it
cd ../ # Go one directory up (in order to get to project root)
source settings.conf # Import settings.conf
if ([ $log_wallpaper_changes = "true" ] || [ $log_wallpaper_deletions = "true" ] || [ $log_new_instances = "true" ]) && [ $log = "true" ]; then # If wallpaper changes/deletion/new instances logging is (are) true AND if logging is enabled.
    date=$(date +%Y-%m-%d) # yy-mm-dd
    time=$(date +%r) # X:YY:ZZ AM/PM
    time=${time::-1} # Remove last character (which is blank)
    source settings.conf # Re-import file in order to fill date and time variables
    if [[ ! -d log ]]; then # If log dir doesn't exist
        mkdir log
    fi
    cd log
    if [[ ! -f full-log.log ]]; then # If full-log file doesn't exist
        touch full-log.log
    fi
    if [[ ! -d $date ]]; then # If log/$date dir doesn't exist
        mkdir $date
    fi
    cd $date
    if [[ ! -f log.log ]]; then # If log/$date/log.log file doesn't exist
        touch log.log
    fi
    cd ../ # Set dir to log/
    echo "$log_time_format$1;" >> full-log.log # Write full-log
    echo "$log_time_format$1;" >> $date/log.log # Write $date/log.log
fi