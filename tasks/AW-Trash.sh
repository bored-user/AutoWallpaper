#!/bin/bash

# ------------------------------------------------------------------------------------------------------------------------
# DISCLAIMER
# ------------------------------------------------------------------------------------------------------------------------
# this file should be called by Nautilus Action action
# if $1 = 1 the script will *delete the AutoWallpaper/trash folder* (which contain all "deleted" wallpapers)
# if it isn't one the script will just move the current wallpaper to trash folder & change the desktop wallpaper
# ------------------------------------------------------------------------------------------------------------------------

if [ $1 -eq 1 ]; then
    if [[ -d /home/$USER/bin/AutoWallpaper/trash ]]; then
        rm -rf /home/$USER/bin/AutoWallpaper/trash # delete trash folder
        notify-send --icon="/home/$USER/bin/AutoWallpaper/img/favico.png" "AutoWallpaper" "Deleted trash folder successfully." # notify
    else
        mkdir /home/$USER/bin/AutoWallpaper/trash
        notify-send --icon="/home/$USER/bin/AutoWallpaper/img/favico.png" "AutoWallpaper" "Trash folder didn't exist, so no files were deleted!" # notify
    fi
else
    if [[ ! -d /home/$USER/bin/AutoWallpaper/trash ]]; then # create trash folder if not created
        mkdir /home/$USER/bin/AutoWallpaper/trash
    fi
    notify-send --icon="/home/$USER/bin/AutoWallpaper/img/favico.png" "AutoWallpaper" "Moving wallpaper to trash..." # notify
    wallpaper=$(gsettings get org.gnome.desktop.background picture-uri) # return format: 'file:///path/to/file/file.extension'
    wallpaper=${wallpaper:0,8} # remove " 'file:/// "
    wallpaper=${wallpaper::-1} # remove " ' "
    IFS='/' read -ra wallpaper_path <<< "$wallpaper" # split string
    wallpaper=${wallpaper_path[5]} # get file
    #[0] = [empty];
    #[1] = home;
    #[2] = $USER;
    #[3] = Pictures;
    #[4] = Wallpapers;
    #[5] = Wallpaper_XYZ.jpg
    /home/$USER/bin/AutoWallpaper/tasks/AW-Log.sh "$wallpaper moved to trash" # logging
    /home/$USER/bin/AutoWallpaper/tasks/AW-Change.sh # change wallpaper (otherwise the bluescreen wallpaper will come up)
    mv /home/$USER/Pictures/Wallpapers/$wallpaper /home/$USER/bin/AutoWallpaper/trash # move file to trash folder
fi