#!/bin/bash

# requires bti (twitter cli)

if [ ! -d $HOME/.mineMonitor ]; then
  mkdir $HOME/.mineMonitor
fi

if [ ! -f $HOME/.mineMonitor/lastBlock ]; then
  echo 0 > $HOME/.mineMonitor/lastBlock
fi

currBlock=$(links -dump http://eligius.st/~gateway/stats/recent-blocks | grep -A 2 "Age" | tail -n 1 | sed 's/.*\([0-9]\{4\}-\)/\1/' | awk '{print $9}' | tr -d ",")
lastBlock=$(cat $HOME/.mineMonitor/lastBlock)

echo Last Block:    $lastBlock
echo Current Block: $currBlock

if [ $currBlock -gt $lastBlock ]; then
  echo "@tuxavant #Eligius mined a new #bitcoin block: $currBlock" | bti
  echo $currBlock > $HOME/.mineMonitor/lastBlock
else
  echo "Still working on blocks..."
fi
