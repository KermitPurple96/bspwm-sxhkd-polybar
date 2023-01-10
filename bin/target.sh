#!/bin/bash
 
 
target=$(/usr/bin/cat ~/.config/bin/target.txt)
 
if [[ $target =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
   
  echo "%{F#ff0000}什%{F#ffffff} $target%{u-}"
 
else
    echo "%{F#ffffff}$(echo "no target") %{F#ff0000}什 %{u-}"
fi
