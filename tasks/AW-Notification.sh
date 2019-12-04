#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # Get current path (where this script is being executed)
cd $dir # Change directory to it
cd ../ # Go one directory up (in order to get to project root)
source settings.conf
if [ ! -z ${1+x} ] && [ ! -z ${2+x} ]; then # $1 = Message
    cd $2                                   # $2 = Condition
    source settings.conf                    # $3 = Urgency (values: "urgent" or unset). 
    if [ -z ${4+x} ]; then
        let $4=default
    fi
    if ([ ${!3} = "true" ] && [ $notification = "true" ]) || [ $4 = "urgent" ]; then # If new instance fail AND notification options are true
        if [ -f img/favico ]; then # If file exist
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "$1" # Notify
        else
            tasks/AW-Image.sh # Download the file
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "$1" # Notify
        fi
    fi
else
    tasks/AW-Notification.sh "AW-Notify script called without parameters. Exiting..." 0 "urgent"
    exit
fi