# RetroPieBackupScript

A set of backup scripts for RetroPie

# Install

Clone the repo to home directory
```
$ cd $HOME && git clone https://github.com/berkona/RetroPieBackupScript.git
```

Change working directory to be the install dir
```
$ cd RetroPieBackupScript
```

Install the scripts
```
$ ./install.sh
```

You should be prompted to link you Dropbox account by creating a new app.  My preference is to create an app with the name scheme:
`RetroPieBackupScript_<UNIX_EPOCH>` where `<UNIX_EPOCH>` is the number of seconds or milliseconds since the Unix Epoch.  You can get this value through any JS Console (i.e., `Date.now()`).

# Hourly Save Backups
You can add an entry to crontab for the raspberry pi via
```
$ crontab -e
```

You can add a config to run it every hour via
```
33 * * * * /home/pi/RetroPieBackupScript/sync-saves.sh
```


# License
[MIT](https://opensource.org/licenses/MIT)

# Prior Art
This code is based partially on prior work by two different authors.

- Original concept was posted at [the Retropie subreddit by u/reggietheporpoise](https://www.reddit.com/r/RetroPie/comments/8uj3hm/quick_tool_to_backup_all_save_statessram_to/)
- The code for `sync-saves.sh` was based on the script [posted by u/esmith213](https://www.reddit.com/r/RetroPie/comments/8uj3hm/quick_tool_to_backup_all_save_statessram_to/e1hz67o/)
