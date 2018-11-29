#!/bin/sh
# with bind mounted volume
vol="./docker_volume"
if [ "$1" ]; then
    vol=$1
fi
vol=$(realpath $vol)
# make it otherwise root owns it
mkdir -p $vol
docker run --runtime=nvidia -it -v $vol:/tmp --rm --name tf_devel cottrell/tensorflow:nvidia-devel /bin/bash
