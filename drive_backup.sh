#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR"
BACKUP_DIR="$SCRIPT_DIR/_backups"

GDRIVE_REMOTE="gdrivenew"
GDRIVE_FOLDER="Backupsviascript"

DATE=$(date + "%Y-%m-%d")
BACKUP_FILE="backup_$DATE.tar.gz"

echo "Starting the script..."
echo "Source Directory: $SOURCE_DIR"

mkdir -p "$BACKUP_DIR"

echo "Compressing Backup..."
tar -czf "$BACKUP_DIR/$BACKUP_FILE" \
	--exclude="_backups" \
	.

if [ $? -ne 0 ]; then
	echo "Backup compression failed..."
	exit 1
fi

echo "COmpression passed...."

echo "Uploading to Google drive now..."
rclone copy "$BACKUP_DIR/$BACKUP_FILE" "$GDRIVE_REMOTE:$GDRIVE_FOLDER"

if [ $? -ne 0 ]; then 
	echo "Backup to google drive failed"
	exit 1
fi

echo "Removing local backup"
rm -f "$BACKUP_DIR/$BACKUP_FILE"

echo "Backup completed successfully..."

