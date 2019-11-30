dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $dir
cd ../
source settings.conf
if [ $log = "true" ]; then 
    if [ $log_wallpaper_changes = "true" ] || [ $log_wallpaper_deletions = "true" ] || [ $log_new_instances = "true" ]; then
        date=$(date +%Y-%m-%d) # yy-mm-dd
        time=$(date +%r) # X:YY:ZZ AM/PM
        time=${time::-1} # Remove last character (which is blank)
        source settings.conf
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
        if [[ ! -f log.log ]]; then # If log/$date/ file doesn't exist
            touch log.log
        fi
        cd ../ # Set dir to log/
        echo "$log_time_format$1;" >> full-log.log # Write full-log
        echo "$log_time_format$1;" >> $date/log.log # Write $date/log.log
    fi
fi