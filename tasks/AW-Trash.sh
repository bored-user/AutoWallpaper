#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # Get current path (where this script is being executed)
cd $dir # Change directory to it
cd ../ # Go one directory up (in order to get to project root)
source settings.conf # Import settings.conf

# ------------------------------------------------------------------------------------------------------------------------
# DISCLAIMER
# ------------------------------------------------------------------------------------------------------------------------
# This file should be called by Nautilus Action action
# If $1 = 1 the script will *delete the AutoWallpaper/trash folder* (which contain all "deleted" wallpapers)
# If it isn't 1 the script will just move the current wallpaper to trash folder & change the desktop wallpaper
# ------------------------------------------------------------------------------------------------------------------------

if [ $1 -eq 1 ]; then # If par 1 = 1
    if [[ -d trash ]]; then # If trash folder exist
        rm -rf trash # Delete trash folder
        if [ $notification_delete_trash_folder = "true" ] && [ $notification = "true" ]; then # If both notification options are set to true
            if [ -f img/favico ]; then # If file exist
                notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Deleted trash folder successfully." # Notify
            else
                tasks/AW-Image.sh # Download the file
                notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Deleted trash folder successfully." # Notify
            fi       
        fi
    else
        mkdir trash # Create trash directory
        if [ $notification_delete_trash_folder_fail = "true" ] && [ $notification = "true" ]; then # If both options are true
            if [ -f img/favico ]; then # If file exist
                notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Trash folder didn't exist, so no files were deleted!" # Notify
            else
                tasks/AW-Image.sh # Donwload the file
                notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Trash folder didn't exist, so no files were deleted!" # Notify
            fi
        fi
    fi
else
    if [[ ! -d trash ]]; then # Create trash folder if not created
        mkdir trash
    fi
    if [ $notification_delete_wallpaper = "true" ] && [ $notification = "true" ]; then # If both options are true
        if [ -f img/favico ]; then # If file exist
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Moving wallpaper to trash..." # Notify
        else
            tasks/AW-Image.sh # Download the file
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Moving wallpaper to trash..." # Notify
        fi
    fi
    wallpaper=$(gsettings get org.gnome.desktop.background picture-uri) # Return format: 'file:///path/to/file/file.extension'
    wallpaper=${wallpaper:0,8} # Remove " 'file:/// "
    wallpaper=${wallpaper::-1} # Remove " ' "
    IFS='/' read -ra wallpaper_path <<< "$wallpaper" # Split string
    wallpaper=${wallpaper_path[-1]} # Get file (last item of array)
    if [ $log_wallpaper_deletions = "true" ] && [ $log = "true" ]; then # If both options are true
        tasks/AW-Log.sh "$wallpaper moved to trash" # Logging
    fi
    tasks/AW-Change.sh # Change wallpaper (otherwise the bluescreen wallpaper will come up)
    if [ $wallpaper_folder_location != "" ] && [ -d $wallpaper_folder_location ]; then # If the folder location is valid AND if it's a directory
        mv $wallpaper_folder_location/$wallpaper trash # Move file to trash folder
    else
        if [ -f img/favico ]; then # If file exsit
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Wallpaper folder location isn't set or isn't a valid directory. Using default ones." # Notify
        else
            tasks/AW-Image.sh # Download the file
            notify-send --icon="$PWD/img/favico" "AutoWallpaper" "Wallpaper folder location isn't set or isn't a valid directory. Using default ones." # Notify
        fi
        mv $PWD/wallpapers/$wallpaper trash # Move default wallpaper to trash
    fi
fi