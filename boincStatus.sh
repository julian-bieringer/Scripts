#!/bin/zsh
while test 1 != 0; do
	clear;
	boinccmd --get_tasks | grep "fraction" | cut -d " " -f6- | awk '{print $1*100"%"}';
	sleep 60;
done
