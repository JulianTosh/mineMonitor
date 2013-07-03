#!/bin/bash 

ping -c 2 google.com > /dev/null 2>&1
if [ $? -gt 0 ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S'): No network connectivity" >> ~/mine.log
fi
