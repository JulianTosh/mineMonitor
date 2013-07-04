#!/bin/bash

pgrep bfgminer > /dev/null
if [ $? -eq 0 ]; then

  target=90000
  hashRate=$(/var/install/bfgminer/bfgminer-rpc | grep "\[MHS av\]" | awk '{print $4}' | sed 's/\..*$//')

  if [ $hashRate -gt 0 ]; then
    #echo Hash rate OK: $hashRate
    if [ $hashRate -lt $target ]; then
      echo "$(date '+%Y-%m-%d %H:%M:%S'): Hash rate too low ($hashRate). Restarting bfgminer." >> $HOME/mineMonitor.log
      pkill bfgminer
    fi
  fi
fi
