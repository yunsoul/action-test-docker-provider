#!/bin/sh -l

apt update
apt install -y software-properties-common
add-apt-repository ppa:ethereum/ethereum
apt install -y solc
apt install -y libssl-dev python3-dev python3-pip
yes | pip3 install mythril
myth version
myth analyze /github/workspace/*.sol -o json

#ls -al /
#ls -R /github
#ls -R /home
#ls -R /mnt
#ls -R /run
#ls -R /tmp

#echo "Hello $1"
#time=$(date)
#echo "::set-output name=time::$time"
