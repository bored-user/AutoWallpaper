#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $dir
cd ../
source settings.conf
if [ $wallpaper_folder_location != "" ] && [ -d $wallpaper_folder_location ]; then
    wallpaper=$(ls $wallpaper_folder_location | shuf -n 1) # Randomize wallpaper
    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_folder_location/$wallpaper" # Set wallpaper
else
    if [ -f img/favico ]; then
        notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Wallpaper folder location isn't set or isn't a valid directory. Using default ones." # Notify
    else
        tasks/AW-Image.sh
        notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Wallpaper folder location isn't set or isn't a valid directory. Using default ones." # Notify
    fi
    wallpaper=$(ls $PWD/wallpapers | shuf -n 1) # Randomize wallpaper
    gsettings set org.gnome.desktop.background picture-uri "file://$PWD/wallpapers/$wallpaper" # Set wallpaper
fi
if [ $log_wallpaper_changes = "true" ] && [ $log = "true" ]; then
    tasks/AW-Log.sh $wallpaper # Logging
fi
if [ $notification_wallpaper_change = "true" ] && [ $notification = "true" ]; then
    if [ -f img/favico ]; then
        notify-send -t 1000 --icon="$PWD/img/favico" "AutoWallpaper" "Wallpaper changed. New wallpaper: $wallpaper" # Notify
    else
        tasks/AW-Image.sh
        notify-send -t 1000 --icon="$PWD/img/favico" "AutoWallpaper" "Wallpaper changed. New wallpaper: $wallpaper" # Notify
    fi
fi