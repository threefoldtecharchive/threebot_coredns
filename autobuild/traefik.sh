#!/bin/bash
set -ex

apt-get update
apt-get install git gcc make wget -y

# make output directory
ARCHIVE=/tmp/archives
TRAEFIK_FLIST=/tmp/traefik_flist_dir


mkdir -p $ARCHIVE
mkdir -p $TRAEFIK_FLIST/bin

pushd /tmp

wget https://github.com/containous/traefik/releases/download/v2.0.0-alpha4/traefik_v2.0.0-alpha4_linux_amd64.tar.gz
tar -xf traefik_v2.0.0-alpha4_linux_amd64.tar.gz 
cp traefik $TRAEFIK_FLIST/bin
# copy /etc/ssl too 
cp /etc/ssl -R $TRAEFIK_FLIST
popd 

tar -czf "/tmp/archives/traefik.tar.gz" -C $TRAEFIK_FLIST .