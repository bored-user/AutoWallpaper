#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $dir
cd ../
source settings.conf

# ------------------------------------------------------------------------------------------------------------------------
# DISCLAIMER
# ------------------------------------------------------------------------------------------------------------------------
# This file should be called by Nautilus Action action
# If $1 = 1 the script will *delete the AutoWallpaper/trash folder* (which contain all "deleted" wallpapers)
# If it isn't 1 the script will just move the current wallpaper to trash folder & change the desktop wallpaper
# ------------------------------------------------------------------------------------------------------------------------

if [ $1 -eq 1 ]; then
    if [[ -d trash ]]; then
        rm -rf trash # Delete trash folder
        if [ $notification_delete_trash_folder = "true" ] && [ $notification = "true" ]; then
            notify-send --icon="$dir/img/favico.png" "AutoWallpaper" "Deleted trash folder successfully." # Notify
        fi
    else
        mkdir trash
        if [ $notification_delete_trash_folder_fail = "true" ] && [ $notification = "true" ]; then
            notify-send --icon="$dir/img/favico.png" "AutoWallpaper" "Trash folder didn't exist, so no files were deleted!" # Notify
        fi
    fi
else
    if [[ ! -d trash ]]; then # Create trash folder if not created
        mkdir trash
    fi
    if [ $notification_delete_wallpaper = "true" ] && [ $notification = "true" ]; then
        notify-send --icon="$dir/img/favico.png" "AutoWallpaper" "Moving wallpaper to trash..." # Notify
    fi
    wallpaper=$(gsettings get org.gnome.desktop.background picture-uri) # Return format: 'file:///path/to/file/file.extension'
    wallpaper=${wallpaper:0,8} # Remove " 'file:/// "
    wallpaper=${wallpaper::-1} # Remove " ' "
    IFS='/' read -ra wallpaper_path <<< "$wallpaper" # Split string
    wallpaper=${wallpaper_path[5]} # Get file
    #[0] = [empty];
    #[1] = home;
    #[2] = $USER;
    #[3] = Pictures;
    #[4] = Wallpapers;
    #[5] = Wallpaper_XYZ.jpg
    if [ $log_wallpaper_deletions = "true" ] && [ $log = "true" ]; then
        tasks/AW-Log.sh "$wallpaper moved to trash" # Logging
    fi
    tasks/AW-Change.sh # Change wallpaper (otherwise the bluescreen wallpaper will come up)
    mv $wallpaper_folder_location/$wallpaper trash # Move file to trash folder
fi