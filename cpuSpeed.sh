#!/bin/zsh
watch -n1 "grep \"^[c]pu MHz\" /proc/cpuinfo | sort -n -r"
