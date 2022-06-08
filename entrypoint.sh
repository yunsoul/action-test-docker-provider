#!/bin/sh -l

#
# common
#
#apt update
#apt install -y software-properties-common
#add-apt-repository -y ppa:ethereum/ethereum
#apt install -y solc

#
# Mythril
#apt install -y libssl-dev python3-dev python3-pip
#yes | pip3 install mythril
#myth version
#myth analyze /github/workspace/*.sol -o json

#ls -al /
#ls -R /github
#ls -R /home
#ls -R /mnt
#ls -R /run
#ls -R /tmp

#echo "Hello $1"
#time=$(date)
#echo "::set-output name=time::$time"

#
# Oyente
#
apt install -y python
python --version

#apt install -y python3
#apt install -y ethereum
#wget https://github.com/Z3Prover/z3/archive/z3-4.5.0.tar.gz
#tar -xvzf z3-4.5.0.tar.gz
#cd z3-z3-4.5.0

