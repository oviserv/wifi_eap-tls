#!/usr/bin/env sh

set -e
source ${SCRIPTDIR}/config.sh

# Start FreeRadius

while [ ! -f "${INITFINISHED}" ]; do sleep 1; done

cd /etc/raddb

if [ -z "$DEBUG" ]; then
    exec radiusd -f
else 
    exec radiusd -X
fi
