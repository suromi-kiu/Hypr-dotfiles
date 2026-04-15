#!/usr/bin/env bash

function do_all(){
  if [ $(wc -c target.txt | awk '{print $1}') -gt 1 ]; then
      target=$(awk '{print}' target.txt)
      echo "{\"text\": \" $target\", \"class\": \"connected\"}"
  else
      echo "{\"text\": \" Not target\", \"class\": \"disconnected\"}"
  fi
}

if [[ -f "target.txt" ]]; then
  do_all
else
  touch target.txt
  do_all
fi
