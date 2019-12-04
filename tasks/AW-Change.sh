#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # Get current path (where this script is being executed)
cd $dir # Change directory to it
cd ../ # Go one directory up (in order to get to project root)
source settings.conf # Import settings.conf
if [ ! -z ${wallpaper_folder_location+x} ] && [ -d $wallpaper_folder_location ]; then # If variable is set AND is a valid dir
    wallpaper=$(ls $wallpaper_folder_location | shuf -n 1) # Randomize wallpaper
    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_folder_location/$wallpaper" # Set wallpaper
else
    tasks/AW-Notification.sh "Wallpaper folder location isn't set or isn't a valid directory. Using default ones." 0 "urgent"
    wallpaper=$(ls $PWD/wallpapers | shuf -n 1) # Randomize wallpaper
    gsettings set org.gnome.desktop.background picture-uri "file://$PWD/wallpapers/$wallpaper" # Set wallpaper
fi
if [ $log_wallpaper_changes = "true" ] && [ $log = "true" ]; then
    tasks/AW-Log.sh $wallpaper # Logging
fi
tasks/AW-Notification.sh "Wallpaper changed. New wallpaper: $wallpaper" "notification_wallpaper_change"