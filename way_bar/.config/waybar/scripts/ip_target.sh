#!/usr/bin/env bash

path_to_file="/home/suromih/.config/waybar/scripts/target.txt"

function do_all(){
  if [ $(wc -c $path_to_file | awk '{print $1}') -gt 1 ]; then
      target=$(awk '{print}' $path_to_file)
      echo "{\"text\": \" $target\", \"class\": \"connected\"}"
  else
      echo "{\"text\": \" Not target\", \"class\": \"disconnected\"}"
  fi
}

if [[ -f ".config/waybar/scripts/target.txt" ]]; then
  do_all
else
  touch $path_to_file
  do_all
fi
