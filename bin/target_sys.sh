#!/bin/bash

ttl=$(/usr/bin/cat /home/kermit/.config/bin/ttl.txt)
target_name=$(/usr/bin/cat /home/kermit/.config/bin/target_sys.txt)

if [[ $ttl == "windows" ]]; then
  
    echo -ne "$target_name %{F#00AFEF}%{u-}"

elif [[ $ttl == "linux" ]]; then

    echo -ne "$target_name %{F#000000} %{u-}"

elif [[ $ttl == "" ]]; then

  echo -ne "$(echo "no system") %{F#FF4600} %{u-}"

fi
