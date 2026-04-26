#!/usr/bin/env bash

function do_all(){
  if [ $(wc -c /home/suromih/.config/waybar/scripts/target.txt | awk '{print $1}') -gt 1 ]; then
      target=$(awk '{print}' target.txt)
      echo "{\"text\": \" $target\", \"class\": \"connected\"}"
  else
      echo "{\"text\": \" Not target\", \"class\": \"disconnected\"}"
  fi
}

if [[ -f ".config/waybar/scripts/target.txt" ]]; then
  do_all
else
  touch /home/suromih/.config/waybar/scripts/target.txt
  do_all
fi
