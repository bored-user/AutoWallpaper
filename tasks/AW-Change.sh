#!/bin/bash
wallpaper=$(ls ~/Pictures/Wallpapers | shuf -n 1)
gsettings set org.gnome.desktop.background picture-uri "file:///home/$USER/Pictures/Wallpapers/$wallpaper"
/home/$USER/bin/AutoWallpaper/tasks/AW-Log.sh $wallpaper 