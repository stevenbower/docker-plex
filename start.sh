#!/bin/bash

rm -rf /var/run/*
rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

TARGET_UID=$(stat -c "%u" /data)
TARGET_GID=$(stat -c "%g" /data)

groupmod -g ${TARGET_GID} plex
usermod -u ${TARGET_UID} -g ${TARGET_GID} plex

HOME=/config sudo -E -u plex "/usr/sbin/start_pms"
