#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

DOCKER_IMAGE=${DOCKER_IMAGE:-greenrenovatedbondspay/greenrenovatedbondsd-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/greenrenovatedbondsd docker/bin/
cp $BUILD_DIR/src/greenrenovatedbonds-cli docker/bin/
cp $BUILD_DIR/src/greenrenovatedbonds-tx docker/bin/
strip docker/bin/greenrenovatedbondsd
strip docker/bin/greenrenovatedbonds-cli
strip docker/bin/greenrenovatedbonds-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
