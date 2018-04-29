#!/bin/bash

# citation for coshell
# https://github.com/gdm85/coshell

if [ $# -ne 2 ]; then
	echo "Too few arguments provided! Correct usage: youtube-dl-batch <input_file> <output_directory>"; 
	exit 1;
fi;


urlFile=$1
outputDirectory=$2;
coShellInput=""

if [ ${outputDirectory:${#outputDirectory}-1:1} == '/' ]; then #check if output directory ends on "/", e.g. /home/{USER}/Music/
    outputDirectory=${outputDirectory:0:${#outputDirectory}-1} #if output directory ends on "/", remove the last character so the output will look like /home/{USER}/Music
fi;

while IFS='' read -r line || [[ -n "$line" ]]; do
    coShellInput=$coShellInput$"youtube-dl -o \"$outputDirectory/%(title)s.%(ext)s\" --extract-audio --audio-format mp3 --audio-quality 0 --external-downloader aria2c --external-downloader-args \"-x 16 -s 16 -k 1M\" $line\n";
done < $urlFile #for each line (url) in the file call youtube-dl with outputDirectory\title.extension and use aria2c as a downloader to support parallel download connections

echo -ne $coShellInput

#remove last \n
coShellInput=${coShellInput:0:${#coShellInput}-2}

#call co shell to run each youtube-dl command with one url in a sperate job one per core
echo -e $coShellInput | coshell
