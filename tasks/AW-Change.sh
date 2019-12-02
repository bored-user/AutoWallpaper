#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $dir
cd ../
source settings.conf
wallpaper=$(ls $wallpaper_folder_location | shuf -n 1) # Randomize wallpaper
gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_folder_location/$wallpaper" # Set wallpaper
if [ $log_wallpaper_changes = "true" ] && [ $log = "true" ]; then
    tasks/AW-Log.sh $wallpaper # Logging
fi
if [ $notification_wallpaper_change = "true" ] && [ $notification = "true" ]; then
    notify-send -t 1000 --icon="$dir/img/favico.png" "AutoWallpaper" "Wallpaper changed. New wallpaper: $wallpaper" # Notify
fi