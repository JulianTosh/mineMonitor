#!/bin/bash

echo "$(date '+%Y-%m-%d %H:%M:%S'): Started mine.sh." >> ~/mine.log

while [ 1 ]; do
  bitcoinAddr=$(tac ~/bin/bitcoin.addr | head -n 1)
  pgrep bfgminer
  if [ $? -eq 0 ]; then
    echo 'bfgminer is running...'
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S'): bfgminer not found. Mining to $bitcoinAddr..." >> ~/mine.log
    bfgminer -o stratum+tcp://stratum.mining.eligius.st:3334 --api-listen --api-allow=127.0.0.1/32 -x socks5h://127.0.0.1:9050 -O $bitcoinAddr
    echo "$(date '+%Y-%m-%d %H:%M:%S'): bfgminer has stopped." >> ~/mine.log
  fi
  echo 'Watchdog sleeping...'
  sleep 30
done
