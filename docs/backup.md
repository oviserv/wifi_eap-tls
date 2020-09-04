# Backup of FreeRadius configuration

The configuration of the FreeRadius server is stored on a docker volume. A backup of this data can be made by running the provided backup.sh script:
- Run `./scripts/start_management.sh` as root (or with sudo) in the main directory of this repository
- Run `./backup.sh`
- Close the shell

This creates a backup file in the backup directory. The file name of the backup file includes the date. Only the latest backup made on a specific date is kept.

# Restore of FreeRadius configuration

The configuration is restored automatically when at container startup the docker volume is not populated and a backup file is available in the backup directory. The most recent backup is selected.
