#!/bin/bash
INSTALL_DIR=$(pwd)
echo "Cloning repo to $HOME/Dropbox-Uploader"
cd $HOME
git clone https://github.com/andreafabrizi/Dropbox-Uploader.git
cd $HOME/Dropbox-Uploader
echo "Linking to dropbox account." 
./dropbox_uploader.sh info

echo "Linking to retropie menu"
cd $INSTALL_DIR
mkdir -p /home/pi/RetroPie/retropiemenu/Backup
rm /home/pi/RetroPie/retropiemenu/Backup/SyncWithDropbox.sh
ln -s $INSTALL_DIR/sync-saves.sh /home/pi/RetroPie/retropiemenu/Backup/Sync_Saves_With_Dropbox.sh

echo "Done."

