#!/bin/bash

# Configuration 


SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

SOURCE_DIR="$SCRIPT_DIR"


BACKUP_DIR="$SCRIPT_DIR/_backups"


S3_BUCKET="s3://my-bucket-by-thedevopsrite"


DATE=$(date +"%Y-%m-%d")

BACKUP_FILE="backup_$DATE.tar.gz"


echo "Starting the script..."
echo "Source Directory: $SOURCE_DIR"

mkdir -p "$BACKUP_DIR"

# creating compressed backup

echo "Compressing Items for backup..."
tar -czf "$BACKUP_DIR/$BACKUP_FILE" \
	--exclude="_backups" \
	.

if [ $? -ne 0 ]; then
	echo "Backup compression failed..."
	exit 1
fi


# uploadig to s3

echo "Uploading to the S3 Bucket..."
aws s3 cp "$BACKUP_DIR/$BACKUP_FILE" "$S3_BUCKET/$BACKUP_FILE"

if [ $? -ne 0 ]; then
	echo "S3 Upload failed "
	exit 1
fi


echo "removing local backup after upload "
rm -f "$BACKUP_DIR/$BACKUP_FILE"

echo "BAckup completed "


