#!/bin/sh -l

apt update
apt install -y software-properties-common
add-apt-repository ppa:ethereum/ethereum
apt install -y solc
apt install -y libssl-dev python3-dev python3-pip
yes | pip3 install mythril
myth version
myth analyze $1 -o json




#echo "Hello $1"
#time=$(date)
#echo "::set-output name=time::$time"
