# --==RetroPie Saves Dropbox Syncing Script==--

# Configuration
INSTALL_DIR="$HOME/RetroPieBackupScript"
ROMS_DIR="$HOME/RetroPie/roms"
# A directory to use as scratch space
BACKUP_DIR="$HOME/BackupScript"
# where dropbox-uploader was cloned to
DROPBOX_UPLOADER_PATH="$HOME/Dropbox-Uploader"
# Name of uploaded archive of all saves in Dropbox
SAVE_ARCHIVE_FILE="RetroPie_Save_Backup.tar.gz"
EXTENSIONS_FILE="$INSTALL_DIR/extensions.txt"

# derived variables
ROM_TMP_DIR="$BACKUP_DIR/roms"
TMP_SAVE_ARCHIVE_FILE="$BACKUP_DIR/$SAVE_ARCHIVE_FILE"
DROPBOX_UPLOADER="$DROPBOX_UPLOADER_PATH/dropbox_uploader.sh"

# cleanup files from a failed previous run
rm -rf "$ROM_TMP_DIR"
mkdir -p "$ROM_TMP_DIR"
rm -rf "$TMP_SAVE_ARCHIVE_FILE"

# download compressed backup from dropbox, if any
$DROPBOX_UPLOADER download "$SAVE_ARCHIVE_FILE" "$BACKUP_DIR"

# decompress backup archive
tar -xzvf "$TMP_SAVE_ARCHIVE_FILE" -C "$BACKUP_DIR"

# copy new(er) local save files (per ext list) on this retropie to backup 
rsync -avtWr --update --include '*/' --include-from="$EXTENSIONS_FILE" --exclude '*' "$ROMS_DIR" "$ROM_TMP_DIR"
# copy new(er) backup save files (per ext list) to this retropie from backup 
rsync -avtWr --update --include '*/' --include-from="$EXTENSIONS_FILE" --exclude '*' "$ROM_TMP_DIR" "$ROMS_DIR"

# recompress the backup saves
tar -czvf "$TMP_SAVE_ARCHIVE_FILE" -C "$BACKUP_DIR" roms

# upload compressed backup to dropbox
$DROPBOX_UPLOADER upload "$TMP_SAVE_ARCHIVE_FILE" /

# cleanup scratch files
rm -rf "$ROM_TMP_DIR"
rm -rf "$TMP_SAVE_ARCHIVE_FILE"
