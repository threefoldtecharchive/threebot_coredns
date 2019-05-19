#!/bin/bash
set -ex

apt-get update
apt-get install git gcc wget -y

# make output directory
ARCHIVE=/tmp/archives
THREEBOT_FLIST=/tmp/threebot_coredns


mkdir -p $ARCHIVE
mkdir -p $THREEBOT_FLIST/bin

# install go
GOFILE=go1.12.linux-amd64.tar.gz
wget https://dl.google.com/go/$GOFILE
tar -C /usr/local -xzf $GOFILE
mkdir -p /root/go
export GOPATH=/root/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/go/bin


pushd /tmp
git clone https://github.com/coredns/coredns
cd coredns

echo 'threebot:github.com/threefoldtech/threebot_coredns' >> plugin.cfg
make

chmod +x coredns

cp coredns $THREEBOT_FLIST/bin/

# make sure binary is executable
chmod +x $THREEBOT_FLIST/bin/*

popd

pushd 
git clone https://github.com/threefoldtech/threebot_coredns
cd threebot_coredns/autobuild/
cp Corefile $THREEBOT_FLIST/
cp startup.toml $THREEBOT_FLIST/.startup.toml
popd

tar -czf "/tmp/archives/threebot_coredns.tar.gz" -C $THREEBOT_FLIST .