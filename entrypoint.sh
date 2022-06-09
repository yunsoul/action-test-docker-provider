#!/bin/sh -l

#
# common
#
apt update
apt install -y software-properties-common
apt install -y libssl-dev python3-dev python3-pip
add-apt-repository -y ppa:ethereum/ethereum
apt install -y solc

#
# Mythrilp
#
#yes | pip3 install mythril
#myth version
#myth analyze /github/workspace/*.sol -o json


#
# Oyente
#
python3 --version
apt install -y ethereum
apt install -y wget
wget https://github.com/Z3Prover/z3/archive/z3-4.5.0.tar.gz
tar -xvzf z3-4.5.0.tar.gz
cd z3-z3-4.5.0
python3 scripts/mk_make.py --python
cd build
make
make install
pip3 install requests
pip3 install web3
pip3 install crytic_compile
cd ..
cd ..
pwd
pip3 install oyente
cd oyente/oyente
pwd
python3 oyente.py -s /github/workspace/calls.sol


#
# Securify
#
#apt install -y wget
#wget https://souffle-lang.github.io/ppa/souffle-key.public -O /usr/share/keyrings/souffle-archive-keyring.gpg
#echo "deb [signed-by=/usr/share/keyrings/souffle-archive-keyring.gpg] https://souffle-lang.github.io/ppa/ubuntu/ stable main" | sudo tee /etc/apt/sources.list.d/souffle.list
#apt update
#apt install -y souffle

#echo "Hello $1"
#time=$(date)
#echo "::set-output name=time::$time"


