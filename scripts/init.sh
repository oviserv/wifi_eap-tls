#!/usr/bin/env sh

set -e
umask 0027

DOCKERCOMPOSEFILE=${PWD}/compose.yaml
if [ ! -f "${DOCKERCOMPOSEFILE}" ]; then
    /usr/bin/printf "Run from directory where compose.yaml resides.\n"
    exit 1
fi

mkdir -p backup
mkdir -p provision
cp ./templates/env.j2 ./.env
printf "Edit .env file in this directory\n"
