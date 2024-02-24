#!/bin/bash

# citation for coshell
# https://github.com/gdm85/coshell

# define default values for optional flags

audioFormat="mp3"

# define mandatory flags

urlFile=""
outputDirectory=""

# process parameters

while [ $# -gt 0 ]; do
  case "$1" in
    --inputFile=*)
      urlFile="${1#*=}"
      urlFile="${urlFile//\~/$HOME}"
      echo "Set input file to: $urlFile"
      ;;
    --outputDirectory=*)
      outputDirectory="${1#*=}"
      outputDirectory="${outputDirectory//\~/$HOME}"
      echo "Set output directory to: $outputDirectory"
      ;;
    --audioFormat=*)
      audioFormat="${1#*=}"
      echo "Overrode audio format to: $audioFormat"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument.*\n"
      printf "***************************\n"
      exit 1
  esac
  shift
done


# check mandatory parameters are set

if [[ -z "$urlFile" ]]; then
    echo "--inputFile needs to be set to provide the script with the path to the file with the youtube urls"
    exit 1
fi

if [[ -z "$outputDirectory" ]]; then
    echo "--outputDirectory needs to be set to provide the script with the path to directory where the files should be outputed"
    exit 1
fi

coShellInput="";

if [ ${outputDirectory:${#outputDirectory}-1:1} == '/' ]; then #check if output directory ends on "/", e.g. /home/{USER}/Music/
    outputDirectory=${outputDirectory:0:${#outputDirectory}-1} #if output directory ends on "/", remove the last character so the output will look like /home/{USER}/Music
fi;

while IFS='' read -r line || [[ -n "$line" ]]; do
    coShellInput=$coShellInput$"yt-dlp -o \"$outputDirectory/%(title)s.%(ext)s\" --extract-audio --audio-format $audioFormat --audio-quality 0 --external-downloader aria2c --external-downloader-args \"-x 16 -s 16 -k 1M\" $line\n";
done < $urlFile #for each line (url) in the file call youtube-dl with outputDirectory\title.extension and use aria2c as a downloader to support parallel download connections

echo -ne $coShellInput

#remove last \n
coShellInput=${coShellInput:0:${#coShellInput}-2}

#call co shell to run each youtube-dl command with one url in a sperate job one per core
echo -e $coShellInput | coshell
