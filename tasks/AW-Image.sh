#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # Get current path (where this script is being executed)
cd $dir # Change directory to it
cd ../ # Go one directory up (in order to get to project root)
wget -qO img/favico "https://yt3.ggpht.com/a/AGF-l780UJkGtvM9qZ6dEPig75iDfJYGre5egD5ZIw=s288-c-k-c0xffffffff-no-rj-mo" # Download the file from youtube channel server