#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <Electrum wallet file>"
  exit
fi

walletFile=$1

electrum -w $walletFile getbalance

electrum -w $walletFile -b listaddresses | grep : | sed 's/^.*: //; s/[\",]//g;' | paste - - | grep "\b0$" | head -n 1 | awk '{print $1}' >> $HOME/.mineMonitor/bitcoin.addr

echo "$(date '+%Y-%m-%d %H:%M:%S'): Updated payout address to $(tac $HOME/.mineMonitor/bitcoin.addr | head -n 1). Restarting bfgminer." >> $HOME/mineMonitor.log

pkill bfgminer
