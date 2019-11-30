#!/bin/bash
if [[ ! -d /home/$USER/bin ]]; then # if local bin dir doesn't exist
    mkdir /home/$USER/bin
fi
if [[ ! -d /home/$USER/bin/AutoWallpaper ]]; then # if AW dir doesn't exist
    mkdir /home/$USER/bin/AutoWallpaper
fi
/bin/cp -rf * /home/$USER/bin/AutoWallpaper
mkdir /home/$USER/bin/AutoWallpaper/trash
exit