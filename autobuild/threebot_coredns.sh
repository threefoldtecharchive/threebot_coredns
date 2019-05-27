#!/bin/bash
set -ex

apt-get update
apt-get install git gcc make wget -y

# make output directory
ARCHIVE=/tmp/archives
THREEBOT_FLIST=/tmp/threebot_coredns_flist_dir


mkdir -p $ARCHIVE
mkdir -p $THREEBOT_FLIST/bin

# install go
GOFILE=go1.12.linux-amd64.tar.gz
wget https://dl.google.com/go/$GOFILE
tar -C /usr/local -xzf $GOFILE
mkdir -p /root/go
export GOPATH=/root/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/go/bin


git clone https://github.com/coredns/coredns /tmp/coredns

pushd /tmp/coredns
    echo 'threebot:github.com/threefoldtech/threebot_coredns' >> plugin.cfg
    make
    chmod +x coredns

    cp coredns $THREEBOT_FLIST/bin/

popd


git clone https://github.com/threefoldtech/threebot_coredns /tmp/threebot_coredns
pushd /tmp/threebot_coredns
    cp autobuild/Corefile $THREEBOT_FLIST/
popd


# copy /etc/ssl too 
cp /etc/ssl -R $THREEBOT_FLIST


# make sure binary is executable
chmod +x $THREEBOT_FLIST/bin/*

tar -czf "/tmp/archives/threebot_coredns.tar.gz" -C $THREEBOT_FLIST .