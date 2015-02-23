#!/bin/bash
# USE: remove_releases.sh "test" $HOME/Tmp
APP_NAME=$1
DEPLOYMENT_DIR=$2
BASE_PATH=$DEPLOYMENT_DIR/$APP_NAME

mix release.clean --implode
cd $BASE_PATH
bin/$APP_NAME stop
cd ..
chmod -R 777 $APP_NAME/
rm -r $APP_NAME/
rm $APP_NAME-*.tar.gz