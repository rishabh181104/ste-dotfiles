#!/bin/bash
while true; do
    actual=$(cat /sys/class/backlight/*/actual_brightness)
    max=$(cat /sys/class/backlight/*/max_brightness)
    percent=$(( actual * 100 / max ))
    echo "$percent" > /tmp/brightness
    sleep 1
done 