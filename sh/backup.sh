#!/usr/bin/env bash

ORIGIN=./
TARGET=~/backups
BACKUPDATE=$(date +%Y.%m.%d-%H:%M:%S)
CURRENT=`pwd`
BASENAME=`basename "$CURRENT"`

if [ -d TARGET=~/backups ]; then
  :
else
  mkdir ~/backups
fi

tar -cvf $TARGET/backup-$BASENAME-$BACKUPDATE.tar.gz $ORIGIN

if [ -f $TARGET/backup-$BASENAME-$BACKUPDATE.tar.gz ]; then
  tput setaf 2
  echo 'backup created ✔'
  echo $TARGET/backup-$BASENAME-$BACKUPDATE.tar.gz
  tput sgr0
else
  tput setaf 1
  echo 'something went wrong ✖'
  tput sgr0
fi
