#!/usr/bin/env sh

# Backup the directory to a tar file

. "${SCRIPTDIR}/config.sh"

umask 337

DATECODE=$(/bin/date "+%Y%m%d")
FILE=${BACKUPDIR}/${DATECODE}_backup.tar.gz

/bin/tar -czvf "${FILE}" "${RADIUSDIR}" "${PROVISIONDIR}"

