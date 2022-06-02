#!/bin/sh -l

sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:ethereum/ethereum
sudo apt install -y solc
sudo apt install -y libssl-dev python3-dev python3-pip
yes | pip3 install mythril
myth version
myth analyze *.sol -o json




#echo "Hello $1"
#time=$(date)
#echo "::set-output name=time::$time"
