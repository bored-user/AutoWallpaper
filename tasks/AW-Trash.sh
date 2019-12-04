#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # Get current path (where this script is being executed)
cd $dir # Change directory to it
cd ../ # Go one directory up (in order to get to project root)
source settings.conf # Import settings.conf

# ------------------------------------------------------------------------------------------------------------------------
# DISCLAIMER
# ------------------------------------------------------------------------------------------------------------------------
# This file should be called by Nautilus Action action
# If $1 is set, the script will *delete the AutoWallpaper/trash folder* (which contain all "deleted" wallpapers)
# If it isn't set, the script will just move the current wallpaper to trash folder & change the desktop wallpaper
# ------------------------------------------------------------------------------------------------------------------------

if [ ! -z ${1+x} ]; then # If par 1 = 1
    if [ -d trash ]; then # If trash folder exist
        rm -rf trash # Delete trash folder
        tasks/AW-Notification.sh "Deleted trash folder successfully." "notification_delete_trash_folder"
    else
        mkdir trash # Create trash directory
        tasks/AW-Notification.sh "Trash folder didn't exist, so no files were deleted!" "notification_delete_trash_folder_fail"
    fi
else
    if [ ! -d trash ]; then # Create trash folder if not created
        mkdir trash
    fi
    tasks/AW-Notification.sh "Moving wallpaper to trash..." "notification_delete_wallpaper"
    wallpaper=$(gsettings get org.gnome.desktop.background picture-uri) # Return format: 'file:///path/to/file/file.extension'
    wallpaper=${wallpaper:0,8} # Remove " 'file:/// "
    wallpaper=${wallpaper::-1} # Remove " ' "
    IFS='/' read -ra wallpaper_path <<< "$wallpaper" # Split string
    wallpaper=${wallpaper_path[-1]} # Get file (last item of array)
    if [ $log_wallpaper_deletions = "true" ] && [ $log = "true" ]; then # If both options are true
        tasks/AW-Log.sh "$wallpaper moved to trash" # Logging
    fi
    tasks/AW-Change.sh # Change wallpaper (otherwise the bluescreen wallpaper will come up)
    if [ ! -z ${wallpaper_folder_location+x} ] && [ -d $wallpaper_folder_location ]; then # If the folder location is valid AND if it's a directory
        mv $wallpaper_folder_location/$wallpaper trash # Move file to trash folder
    else
        tasks/AW-Notification.sh "Wallpaper folder location isn't set or isn't a valid directory. Using default ones." 0 "urgent"
        mv $PWD/wallpapers/$wallpaper trash # Move default wallpaper to trash
    fi
fi