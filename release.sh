#!/bin/bash
# USE: release.sh "test" "0.0.7" "prod" $HOME/Tmp
APP_NAME=$1
VERSION=$2
MIX_ENV=$3
export MIX_ENV
DEPLOYMENT_DIR=$4

BASE_PATH=$DEPLOYMENT_DIR/$APP_NAME
RELEASE_PATH=$BASE_PATH/releases/$VERSION

if [ -d $BASE_PATH ]; then
  echo "Upgrading to:" $VERSION
  mix release
  echo "Creando directorio destino..."
  mkdir $RELEASE_PATH
  echo "Copiando " $APP_NAME-$VERSION.tar.gz " a " $RELEASE_PATH
  cp rel/$APP_NAME/$APP_NAME-$VERSION.tar.gz $RELEASE_PATH/$APP_NAME.tar.gz
  cd $BASE_PATH
  bin/$APP_NAME upgrade $VERSION
else
  echo "Creando primer release"
  mix release
  echo "Creando directorio de despliegue"
  mkdir $BASE_PATH
  echo "Copiando " $APP_NAME-$VERSION.tar.gz " a " $DEPLOYMENT_DIR
  cp rel/$APP_NAME/$APP_NAME-$VERSION.tar.gz $DEPLOYMENT_DIR
  cd $BASE_PATH
  echo "Descomprimiendo tar..."
  tar -xvf $DEPLOYMENT_DIR/$APP_NAME-$VERSION.tar.gz
  echo "Iniciando la aplicación"
  bin/$APP_NAME start
fi