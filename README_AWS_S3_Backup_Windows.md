# Automated Backup to AWS S3 using Bash (Windows Guide)

This README explains **step-by-step** how to:
- Install **Git (Git Bash)** on Windows
- Install **AWS CLI** on Windows
- Add Git & AWS CLI to **Environment Variables**
- Write and save a Bash backup script
- Make the script executable
- Run the script to upload backups to **AWS S3**

---

## 1. Install Git (Git Bash) on Windows

1. Download Git from:
   https://git-scm.com/downloads

2. Run the installer.
3. During installation:
   - Select **Git Bash Here**
   - Choose **Git from the command line and also from 3rd-party software**
   - Keep other options as default

4. Finish installation.

### Verify Git Installation
Open **Git Bash** and run:
```bash
git --version
```

---

## 2. Install AWS CLI on Windows

1. Download AWS CLI from:
   https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

2. Download the **Windows (64-bit)** installer.
3. Run the installer and complete setup.

### Verify AWS CLI Installation
Open **Git Bash** and run:
```bash
aws --version
```

---

## 3. Add Git & AWS CLI to Environment Variables (Windows)

### Git Path
Ensure this path exists in **System PATH**:
```
C:\Program Files\Git\bin
C:\Program Files\Git\usr\bin
```

### AWS CLI Path
Ensure this path exists in **System PATH**:
```
C:\Program Files\Amazon\AWSCLIV2
```

### Steps to Add to PATH
1. Press **Windows + R**
2. Type `sysdm.cpl` → Enter
3. Go to **Advanced** → **Environment Variables**
4. Under **System Variables**, select `Path`
5. Click **Edit**
6. Add the paths above
7. Click **OK** and restart Git Bash

---

## 4. Configure AWS CLI

Run the following command:
```bash
aws configure
```

Enter:
- AWS Access Key ID
- AWS Secret Access Key
- Region (example: ap-south-1)
- Output format: `json`

---

## 5. Create the Backup Script

1. Navigate to the directory you want to back up:
```bash
cd /c/Users/YourName/Documents/my_project
```

2. Create the script file:
```bash
nano s3_backup.sh
```

3. Paste your backup script inside the editor.

4. Save the file:
- Press `CTRL + O`
- Press `Enter`
- Press `CTRL + X`

(Or if using vi)
```bash
:wq
```

---

## 6. Make Script Executable

Run:
```bash
chmod +x s3_backup.sh
```

---

## 7. Execute the Script

If you are in the same directory:
```bash
./s3_backup.sh
```

The script will:
- Compress all files in the directory
- Upload the backup to AWS S3
- Remove the local backup after upload

---

## 8. Notes

- Ensure your S3 bucket already exists
- Ensure IAM user has `AmazonS3FullAccess` or required permissions
- Do NOT commit AWS credentials to GitHub

---

## 9. Next Improvements

- Schedule with Windows Task Scheduler or cron
- Add Google Drive support
- Add email/Slack notifications
- Encrypt backups before upload

---

Happy Automating 🚀
