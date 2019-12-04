#!/bin/bash

# ------------------------------------------------------------------------------------------------------------------------
# DISCLAIMER
# ------------------------------------------------------------------------------------------------------------------------
# This file should be called by tasks/AW-Main.sh file.

# If 0 >= $1 >= 6, the user chose to change wallpaper every week day.
# This script will add a crontab job entry to change wallpaper every week day (0 = Sunday and 6 = Saturday).
# If $1 = "@reboot" (or "reboot"), the script will create a reboot job entry on crontab.

# If $1 isn't any of the values above, the script will notify saying it's an invalid value.
# If $1 isn't set, the script will exit without any notification/ warning/ logging.
# ------------------------------------------------------------------------------------------------------------------------

cd $2 # It gets $2 from AW-Main.sh task. $2 is project root
source settings.conf
cron=$(crontab -l | grep AW) &> /dev/null # Get all cron entries that contain AW
if [ ! -z ${1+x} ]; then # If $1 is set
    if [[ $1 =~ [0-9] ]] && [ $1 -ge 0 ] && [ $1 -le 6 ]; then # If 0 <= $1 <= 6 (because it needs to be greater or equal to 0 and less or equal to 6). Means that variable is set to week day.
        if [[ ! $cron == *"* * * *"*"$PWD/tasks/AW-Change.sh"* ]]; then #  There isn't a week day entry created.
            (crontab -l 2>/dev/null; echo "* * * * $1 $PWD/tasks/AW-Change.sh") | crontab - # Add crontab job. $1 will be 'day(#)' (value between 0 and 6, indicated by the user on settings.conf file).
        fi
    elif [ $1 = "@reboot" ] || [ $1 = "reboot" ]; then # $1 = "reboot" or "@reboot"
        if [[ ! $cron == *"@reboot $PWD/tasks/AW-Change.sh"* ]]; then # No entry created yet.
            (crontab -l 2>/dev/null; echo "@reboot $PWD/tasks/AW-Change.sh") | crontab - # Add crontab job.
        fi
    elif [[ ! $cron == *"@reboot $PWD/tasks/AW-Main.sh"* ]] && [ $wallpaper_new_instance_reboot = "true" ]; then # No **new instance** entry created yet AND new instance on boot variable is set to true
        (crontab -l 2>/dev/null; echo "@reboot $PWD/tasks/AW-Change.sh") | crontab - # Add crontab job.   
    else # If it isn't any of these (it's not valid)
        tasks/AW-Notification.sh "wallpaper_change_interval_unit variable isn't valid. Check settings.conf file." 0 "urgent"
    fi   
fi