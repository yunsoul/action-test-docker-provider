#!/bin/bash -l

#set -e

echo "=================="
echo $1
echo "=================="

REPO=$1

#
# Pre-Operation
#
FOUND=`find . -name "*.sol"`
SCAN_LIST=($(echo "${FOUND[0]}" | tr '=' '\n'))
NUM_FOUND=${#SCAN_LIST[@]}
echo "===> number of file to scan = $NUM_FOUND"

#PREFIX="./"
if [[ 0 == $NUM_FOUND ]]; then
        echo "===> nothing to scan..."
else
        for index in "${!SCAN_LIST[@]}"
        do
				#temp=${SCAN_LIST[index]}
				#temp=${temp#"$PREFIX"}
				#SCAN_LIST[index]=$temp
                echo "${SCAN_LIST[index]}"
        done
fi


#
# common
#
sudo apt update
sudo apt install -y software-properties-common
sudo apt install -y libssl-dev python3-dev python3-pip
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt install -y solc
wget https://raw.githubusercontent.com/yunsoul/action-test-docker-provider/main/conv
chmod +x conv


TOOL_NUM=3
#
# Mythrilp
#
TOOL_ID=0
pip3 install mythril
myth version
for index in "${!SCAN_LIST[@]}"
do
	#myth analyze /github/workspace/${SCAN_LIST[index]} -o json
	myth analyze ${SCAN_LIST[index]} -o json > "result_${TOOL_ID}_${index}.json"
	./conv "create" $TOOL_ID "result_${TOOL_ID}_${index}.json"
done
index=$(( index+1 ))
./conv "merge" $TOOL_ID $index



#
# Slither
#
TOOL_ID=1
pip3 install slither-analyzer
for index in "${!SCAN_LIST[@]}"
do
	slither ${SCAN_LIST[index]} --sarif "result_${TOOL_ID}_${index}.json"
	./conv "create" $TOOL_ID "result_${TOOL_ID}_${index}.json"
done
index=$(( index+1 ))
./conv "merge" $TOOL_ID $index



#
# Semgrep
#
TOOL_ID=2
pip3 install semgrep
semgrep --version
wget https://raw.githubusercontent.com/yunsoul/action-test-docker-provider/main/semgrep_rule.zip
unzip semgrep_rule.zip -d rules
for index in "${!SCAN_LIST[@]}"
do
	semgrep --config ./rules ${SCAN_LIST[index]} --sarif --output "result_${TOOL_ID}_${index}_.json"
	jq '.' "result_${TOOL_ID}_${index}_.json" > "result_${TOOL_ID}_${index}.json"
	./conv "create" $TOOL_ID "result_${TOOL_ID}_${index}.json"
done
index=$(( index+1 ))
./conv "merge" $TOOL_ID $index


./conv "generate" $TOOL_NUM

if [ -f "result.sarif" ]; then
	SVAL=$(cat result.sarif | jq --arg rinfo $REPO '. + {repository: $rinfo}')
	echo $SVAL | jq '.' > s.sarif
	curl -X POST --data-binary "@s.sarif" -H "content-type: application/json" "https://postman-echo.com/post" | jq
fi



#
# Oyente
#
#TOOL_ID=$(( TOOL_ID+1 ))
#apt install -y ethereum
#apt install -y wget
#wget https://github.com/Z3Prover/z3/archive/z3-4.5.0.tar.gz
#tar -xvzf z3-4.5.0.tar.gz
#cd z3-z3-4.5.0
#python3 scripts/mk_make.py --python
#cd build
#make
#make install
#cd ..
#cd ..
#pip3 install requests
#pip3 install web3
#pip3 install crytic_compile
#apt install -y git
#git clone https://github.com/enzymefinance/oyente.git
#cd oyente/oyente
#python3 oyente.py -s /github/workspace/calls.sol
#exit 0

#
# Securify (not work)
#
#apt install -y wget
#wget https://souffle-lang.github.io/ppa/souffle-key.public -O /usr/share/keyrings/souffle-archive-keyring.gpg
#echo "deb [signed-by=/usr/share/keyrings/souffle-archive-keyring.gpg] https://souffle-lang.github.io/ppa/ubuntu/ stable main" | tee /etc/apt/sources.list.d/souffle.list
#apt update
#apt install -y souffle
#apt install -y graphviz
#apt install -y git
#git clone https://github.com/eth-sri/securify2.git
#cd securify2/securify/staticanalysis/libfunctors
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`
#cd ../../..
#pip3 install graphviz
#pip3 install semantic_version
#pip3 install py-solc
#pip3 install py-etherscan-api
#pip3 install requests
#pip3 install -e .
#securify --list

#echo "Hello $1"
#time=$(date)
#echo "::set-output name=time::$time"

exit 0
