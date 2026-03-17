#!/usr/bin/env bash

IFACE=$(ip link show | grep tun0 | awk -F: '{print $2}' | tr -d ' ')

if [ "$IFACE" = "tun0" ]; then
    IP=$(ip -4 addr show tun0 | grep inet | awk '{print $2}' | cut -d/ -f1)
    echo "{\"text\": \" $IP\", \"class\": \"connected\"}"
else
    echo "{\"text\": \" Disconnected\", \"class\": \"disconnected\"}"
fi
