#!/bin/bash

# --==RetroPie Saves Dropbox Syncing Script==--

# Configuration

# Where script was installed to
INSTALL_DIR="$HOME/RetroPieBackupScript"
# Where configs are kept in system
CFG_DIR="/opt/retropie/configs/"
# A directory to use as scratch space
BACKUP_DIR="/tmp/BackupScript"
# where dropbox-uploader was cloned to
DROPBOX_UPLOADER_PATH="$HOME/Dropbox-Uploader"
# Name of uploaded archive of all saves in Dropbox
SAVE_ARCHIVE_FILE="RetroPie_Config_Backup.tar.gz"
# what file to use for filter for save files
EXTENSIONS_FILE="$INSTALL_DIR/config-extensions.txt"

# derived variables
CFG_TMP_DIR="$BACKUP_DIR/configs"
TMP_SAVE_ARCHIVE_FILE="$BACKUP_DIR/$SAVE_ARCHIVE_FILE"
DROPBOX_UPLOADER="$DROPBOX_UPLOADER_PATH/dropbox_uploader.sh"

# cleanup files from a failed previous run
rm -rf "$CFG_TMP_DIR"
mkdir -p "$CFG_TMP_DIR"
rm -rf "$TMP_SAVE_ARCHIVE_FILE"

# download compressed backup from dropbox, if any
$DROPBOX_UPLOADER download "$SAVE_ARCHIVE_FILE" "$BACKUP_DIR"

# decompress backup archive
tar -xzvf "$TMP_SAVE_ARCHIVE_FILE" -C "$BACKUP_DIR"

# copy new(er) local config files (per ext list) on this retropie to backup 
rsync -avtWr --update --include '*/' --include-from="$EXTENSIONS_FILE" --exclude '*' "$CFG_DIR" "$CFG_TMP_DIR"
# copy new(er) backup config files (per ext list) to this retropie from backup 
rsync -avtWr --update --include '*/' --include-from="$EXTENSIONS_FILE" --exclude '*' "$CFG_TMP_DIR" "$CFG_DIR"

# recompress the backup saves
tar -czvf "$TMP_SAVE_ARCHIVE_FILE" -C "$BACKUP_DIR" configs

# upload compressed backup to dropbox
$DROPBOX_UPLOADER upload "$TMP_SAVE_ARCHIVE_FILE" /

# cleanup scratch files
rm -rf "$CFG_TMP_DIR"
rm -rf "$TMP_SAVE_ARCHIVE_FILE"
