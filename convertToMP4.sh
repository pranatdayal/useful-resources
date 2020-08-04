#!/bin/bash
dir=$1
logfile=/tmp/mp4Convert.log

printf "**Beginning conversion now\n" >> $logfile
printf "**Dir: $1\n\n" >> $logfile
shopt -s globstar;

for i in $dir/**/*.mkv; do
    printf "Attempting $i\n" >> $logfile
    #false 1
    ffmpeg -i "$i" -codec copy -movflags +faststart "${i%.*}.mp4"
    if [[ $? -gt 0 ]]; then
        printf "[-]Conversion Failed - verify manually\n\n" >> $logfile
    else
        rm "$i"
        printf "[+]looks good deleting $i\n\n" >> $logfile
    fi
done

