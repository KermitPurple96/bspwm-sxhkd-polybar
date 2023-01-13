#!/bin/bash

ttl=$(/usr/bin/cat /home/kermit/.config/bin/ttl.txt)
target_name=$(/usr/bin/cat /home/kermit/.config/bin/target_sys.txt)

if [[ $ttl == "windows" ]]; then
  
    echo -ne "$target_name %{F#00AFEF}%{u-}"

elif [[ $ttl == "linux" ]]; then

    echo -ne "$target_name %{F#000000} %{u-}"

elif [[ $ttl == "" ]]; then

  echo -ne "%{F#FF0000}  %{F#ffffff}$(echo "no system") %{u-}"

fi
