#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # Get current path (where this script is being executed)
cd $dir # Change directory to it
cd ../ # Go one directory up (in order to get to project root)
source settings.conf # Import settings.conf
if [ $wallpaper_folder_location != "" ] && [ -d $wallpaper_folder_location ]; then # If variable is set AND is a valid dir
    wallpaper=$(ls $wallpaper_folder_location | shuf -n 1) # Randomize wallpaper
    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_folder_location/$wallpaper" # Set wallpaper
else
    if [ -f img/favico ]; then # If favico file exist
        notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Wallpaper folder location isn't set or isn't a valid directory. Using default ones." # Notify
    else
        tasks/AW-Image.sh # Script to download the file
        notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Wallpaper folder location isn't set or isn't a valid directory. Using default ones." # Notify
    fi
    wallpaper=$(ls $PWD/wallpapers | shuf -n 1) # Randomize wallpaper
    gsettings set org.gnome.desktop.background picture-uri "file://$PWD/wallpapers/$wallpaper" # Set wallpaper
fi
if [ $log_wallpaper_changes = "true" ] && [ $log = "true" ]; then
    tasks/AW-Log.sh $wallpaper # Logging
fi
if [ $notification_wallpaper_change = "true" ] && [ $notification = "true" ]; then
    if [ -f img/favico ]; then # If file exist
        notify-send -t 1000 --icon="$PWD/img/favico" "AutoWallpaper" "Wallpaper changed. New wallpaper: $wallpaper" # Notify
    else
        tasks/AW-Image.sh # Download it
        notify-send -t 1000 --icon="$PWD/img/favico" "AutoWallpaper" "Wallpaper changed. New wallpaper: $wallpaper" # Notify
    fi
fi