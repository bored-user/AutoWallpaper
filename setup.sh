#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # Get current path (where this script is being executed)
cd $dir # Change directory to it
clear
echo "Installing unzip..."
sudo apt-get -qq install unzip
echo "Unziping resources.zip file..."
unzip -q resources.zip -d ./resources
suffix=.zip
prefix=resources/
for zip in resources/*
do
    folder=${zip%"$suffix"}
    folder=${file#"$prefix"}
    unzip -q $zip -d ./$folder
done
clear
read -s -p "Do you want to delete resources.zip file (Y/N)? " -N 1 choice
echo "\n"
if [ $choice = "y" ] || [ $choice = "Y" ]
then
    echo "Deleting resources.zip..."
    rm -rf resources.zip
else
    echo "File won't be deleted."
fi
rm -rf INSTALL
rm -rf resources
sudo cp -r $dir /usr/bin/AutoWallpaper
echo "Adding 'AutoWallpaper' folder to "'$PATH'"..."
if [ -f ~/.profile ]
then
    echo "export PATH=$PATH:/usr/bin/AutoWallpaper" >> ~/.profile
elif [ -f ~/.bash_source ]
then
    echo "export PATH=$PATH:/usr/bin/AutoWallpaper" >> ~/.bash_source
else
    echo "Couldn't find the file to write on. "'$PATH'" wasn't modified."
    echo "Current (official) location of script root is: /usr/bin/AutoWallpaper"
fi
exit 0