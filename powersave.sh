#!/bin/bash

## Enable extended globbing features
shopt -s extglob

for cpu in /sys/devices/system/cpu/cpu+([0-9]); do
        core=$(echo $cpu | sed 's:.*/::' | tr -d -c 0-9);
	gov=$(cat $cpu/cpufreq/scaling_governor);
	echo "current governor for $core is: $gov";
	sudo cpufreq-set --cpu $core -g powersave
	gov=$(cat $cpu/cpufreq/scaling_governor);
        echo "governor for $core set to: $gov";
done

echo ""
echo "verification run"
echo ""

for cpu in /sys/devices/system/cpu/cpu+([0-9]); do
        core=$(echo $cpu | sed 's:.*/::' | tr -d -c 0-9);
        gov=$(cat $cpu/cpufreq/scaling_governor);
        echo "current governor for $core is: $gov";
done
