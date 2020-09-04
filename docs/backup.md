# Backup of FreeRadius configuration

The configuration of the FreeRadius server is stored on a docker volume. A backup of this data can be made by running the provided backup.sh script:
- Run `./scripts/start_management.sh` as root (or with sudo) in the main directory of this repository
- Run `./backup.sh`
- Close the shell

This creates a backup file in the backup directory. The file name of the backup file includes the date. Only the latest backup made on a specific date is kept. It is recommended to store the backup in a secure place offline. Warnings:
- This file contains all passwords and key's used to protect your Wifi network including the secret key for the Certificate Authority!
- The clean.sh script deletes the docker volume for FreeRadius and the backup files. Store backup's offline.

# Restore of FreeRadius configuration

The configuration is restored automatically when at container startup the docker volume is not populated and a backup file is available in the backup directory. The most recent backup is selected. The provion directory is not restored but the data is available in the `/etc/raddb/certs` directory. Passwords are kept in `passwords.txt`
