#!/bin/bash
if [[ ! -d ~/bin ]]; then # if local bin dir doesn't exist
    mkdir ~/bin
fi
if [[ ! -d ~/bin/AutoWallpaper ]]; then # if AW dir doesn't exist
    mkdir ~/bin/AutoWallpaper
fi
cp -r * ~/bin/AutoWallpaper
exit