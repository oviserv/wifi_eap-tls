#!/usr/bin/env sh

set -e
umask 0027

DOCKERCOMPOSEFILE=${PWD}/docker-compose.yml
if [ ! -f "${DOCKERCOMPOSEFILE}" ]; then
    /usr/bin/printf "Run from directory where docker-compose.yml resides.\n"
    exit 1
fi

mkdir -p backup
mkdir -p provision
cp ./templates/env.j2 ./.env
printf "Edit .env file in this directory\n"
