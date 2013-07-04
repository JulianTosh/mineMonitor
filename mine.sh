#!/bin/bash

if [ ! -d $HOME/.mineMonitor ]; then
  echo "Creating $HOME/.mineMonitor"
  mkdir $HOME/.mineMonitor
fi

if [ ! -f $HOME/.mineMonitor/bitcoin.addr ]; then
  echo "Please add a bitcoin address to $HOME/.mineMonitor/bitcoin.addr."
  echo "changeAddress.sh might help you."
  exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S'): Started mine.sh." >> $HOME/mineMonitor.log

while [ 1 ]; do
  bitcoinAddr=$(tac $HOME/.mineMonitor/bitcoin.addr | head -n 1)
  pgrep bfgminer
  if [ $? -eq 0 ]; then
    echo 'bfgminer is running...'
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S'): bfgminer not found. Mining to $bitcoinAddr..." >> $HOME/mineMonitor.log
    bfgminer -o stratum+tcp://stratum.mining.eligius.st:3334 --api-listen --api-allow=127.0.0.1/32 -x socks5h://127.0.0.1:9050 -O $bitcoinAddr
    echo "$(date '+%Y-%m-%d %H:%M:%S'): bfgminer has stopped." >> $HOME/mineMonitor.log
  fi
  echo 'Watchdog sleeping...'
  sleep 30
done
