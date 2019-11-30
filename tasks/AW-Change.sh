#!/bin/bash
wallpaper=$(ls /home/$USER/Pictures/Wallpapers | shuf -n 1)
trash=$(ls /home/$USER/bin/AutoWallpaper/trash | grep $wallpaper)
if [ $trash = $wallpaper ]; then
    until [[ ! $trash = $wallpaper ]]; do
        wallpaper=$(ls /home/$USER/Pictures/Wallpapers | shuf -n 1)
        trash=$(ls /home/$USER/bin/AutoWallpaper/trash | grep $wallpaper)
    done
fi
gsettings set org.gnome.desktop.background picture-uri "file:///home/$USER/Pictures/Wallpapers/$wallpaper"
/home/$USER/bin/AutoWallpaper/tasks/AW-Log.sh $wallpaper 