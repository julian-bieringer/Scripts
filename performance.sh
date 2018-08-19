#!/bin/sh
gov=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor);
echo "current governor is: $gov";
sudo cpufreq-set -g performance
gov=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor);
echo "governor set to: $gov";
