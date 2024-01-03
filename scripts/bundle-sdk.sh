#!/bin/bash
set -x
DEST=$CONFIGURATION_BUILD_DIR/$UNLOCALIZED_RESOURCES_FOLDER_PATH
ls ../sdk*tar.gz > /dev/null 2>&1
if [ $? -ne 0 ];
then
  echo "no sdk tarball"
  exit 100
fi
TARBALL=`ls ../sdk*tar.gz|xargs -n 1|tail -n 1`

if [ -f ${TARBALL} ];
then
  tar -xvf ${TARBALL} -C ${DEST}
  if [ $? -eq 0 ];
  then
    exit 0
  else
    echo "Untar Tarball failed."
    exit 200
  fi
else
  echo "Tarball ${TARBALL} not existing."
  exit 100
fi
