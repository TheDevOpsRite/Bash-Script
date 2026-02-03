# Google Drive Backup Using Git Bash & rclone (Windows)

This guide explains how to back up any folder to **Google Drive** using **Git Bash** on **Windows**, with the help of **rclone**.

---

## Prerequisites

- Windows 10 / 11
- Git Bash installed  
- Google account
- Basic knowledge of running shell scripts

---

## Step 1: Install Git Bash (If Not Installed)

Download Git Bash from:
https://git-scm.com/downloads

Install it with default options.

---

## Step 2: Download rclone for Windows

1. Go to the official rclone download page:
   https://rclone.org/downloads/

2. Download:
   `rclone-vX.XX.X-windows-amd64.zip`

3. Extract the ZIP file.
   You will see `rclone.exe` inside the extracted folder.

---

## Step 3: Add rclone to Environment Variables (PATH)

### Recommended (Permanent Setup)

1. Create a folder:
   `C:\Program Files\rclone\`

2. Move `rclone.exe` into that folder.

3. Add it to PATH:
   - Search **Environment Variables**
   - Open **Edit the system environment variables**
   - Click **Environment Variables**
   - Under **System variables**, select **Path**
   - Click **New** and add:
     ```
     C:\Program Files\rclone\
     ```

4. Click OK and **restart Git Bash**

### Verify Installation
```bash
rclone version
```

---

## Step 4: Configure Google Drive Using rclone

Run:
```bash
rclone config
```

Choose the following options:
```
n → New remote
name → gdrive
storage → drive
scope → 1 (Full access)
```

- rclone will open a browser automatically.
- Log in to your Google account.
- Allow access.
- If browser does not open, copy the URL manually and paste it into a browser.

Finish the configuration.

---

## Step 5: Test Google Drive Connection

```bash
rclone lsd gdrive:
```

If folders are listed, Google Drive is connected successfully.

---

## Step 6: Backup Script (Example)

```bash
#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/_backups"
DATE=$(date +"%Y-%m-%d")
BACKUP_FILE="backup_$DATE.tar.gz"

GDRIVE_REMOTE="gdrive"
GDRIVE_FOLDER="Backups"

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_DIR/$BACKUP_FILE" --exclude="_backups" .

rclone copy "$BACKUP_DIR/$BACKUP_FILE" "$GDRIVE_REMOTE:$GDRIVE_FOLDER"

rm -f "$BACKUP_DIR/$BACKUP_FILE"

echo "Backup completed successfully"
```

---

## Step 7: Run the Backup

```bash
bash backup.sh
```

Your backup will appear in:
```
Google Drive → Backups → backup_YYYY-MM-DD.tar.gz
```

---

## Step 8: Automate the Backup

### Option 1: Windows Task Scheduler
- Open **Task Scheduler**
- Create Basic Task
- Trigger: Daily / Weekly
- Action: Start a Program
- Program:
  ```
  C:\Program Files\Git\bin\bash.exe
  ```
- Arguments:
  ```
  /c/path/to/backup.sh
  ```

### Option 2: Cron Job (Linux / WSL)
```bash
crontab -e
```
```bash
0 2 * * * /path/to/backup.sh
```

---

## Notes

- rclone supports encryption, versioning, and multiple cloud providers.
- Always test scripts manually before automating.
- Use absolute paths for reliability.

---

## Channel Name

**The DevOps Rite**
