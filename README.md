# AutoWallpaper #

Script that changes your (GNOME) desktop wallpaper every minute!<br>
Based on a <a href="https://t.me/TaskerSuperBrasilCanal/872">Tasker project</a> created by <a href="https://t.me/TaskerSuperBrasil">Tasker Super Brasil</a> Telegram group.

## Usage ##
Just create a folder on `~/Pictures` named `Wallpapers` and move your wallpapers there!<br>
Every minute, the daemon will randomize a file at `/home/$USER/Pictures/Wallpapers` and set it as desktop background.<br><br>

BTW: You should run the `install.sh` file to make sure everything is correctly installed. **No `sudo` needed.**

## Log ##
The script generates logs inside the `log` folder.<br><br>
**Format:**<br>
* log folder<br>
    * full-log.log<br>
    * date-1<br>
        * log.log<br>
    * date-2<br>
        * log.log<br><br>
Every execution, the `AW-Main.sh` script calls `AW-Change.sh` which calls `AW-Log.sh` script which checks if there's a folder named with the current date (date +%Y-%m-%d). If there's not, it creates it. Every time it logs, it write a new entry on both `full-log.log` and `date-xyz/log.log` files.

## FAQ ##
### Change location ###
If you would like to change the randomization location, just open a text editor that supports `Search and Replace` tools (e.g. Visual Studio Code) and replace `/home/$USER/Pictures/Wallpapers` with `/home/your-user/your-folder/your-folder2` and `~/Pictures/Wallpapers` with `~/your-folder/your-folder2`.

### Start on boot ###
Add the `AW-Main.sh` script to the Startup Appliactions tool.

### Add entries to context menus ###
Install `nautilus-actions` (or an equivalent one, like `caja-actions`).

### Change timeout ###
Search for `sleep 60` and change `60` to the seconds ammount you would like it to take to change background.
