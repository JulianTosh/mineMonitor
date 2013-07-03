#!/bin/bash

electrum -w /home/miner/.electrum/miner1.dat -b listaddresses | grep : | sed 's/^.*: //; s/[\",]//g;' | paste - - | grep "\b0$" | head -n 1 | awk '{print $1}' >> /home/miner/bin/bitcoin.addr

echo "$(date '+%Y-%m-%d %H:%M:%S'): Updated payout address to $(tac /home/miner/bin/bitcoin.addr | head -n 1). Restarting bfgminer." >> ~/mine.log

pkill bfgminer
