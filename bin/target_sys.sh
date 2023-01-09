#!/bin/bash

ttl=$(/usr/bin/cat /home/kermit/.config/bin/ttl.txt)
target_name=$(/usr/bin/cat /home/kermit/.config/bin/target_sys.txt)

if [[ $ttl -eq "windows" ]]; then
  echo -ne "$target_name %{F#00AFEF}"

elif [[ $ttl -eq "linux" ]]; then
  echo -ne "$target_name %{F#000000}"

else 
  echo -ne "No target set"
fi
