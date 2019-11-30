date=$(date +%Y-%m-%d)
time=$(date +%r)
time=${time::-1}
cd /home/$USER/bin/AutoWallpaper
if [[ ! -d log ]]; then # if log dir doesn't exist
    mkdir log
fi
cd log
if [[ ! -f full-log.log ]]; then # if full-log file doesn't exist
    touch full-log.log
fi
if [[ ! -d $date ]]; then # if log/$date dir doesn't exist
    mkdir $date
fi
cd $date
if [[ ! -f log.log ]]; then # if log/$date/ file doesn't exist
    touch log.log
fi
cd ../ # set dir to /home/$USER/bin/AutoWallpaper/log
echo "$date ($time): $1;" >> full-log.log # write full-log
echo "$date ($time): $1;" >> $date/log.log # write $date/log.log