#!/bin/bash
# Convert MKV files to MP4 in a web optimized format

# Supply directory as first arg
dir=$1
logfile=/tmp/mp4Convert.log

printf "**Beginning conversion now\n" >> $logfile
printf "**Dir: $1\n\n" >> $logfile

# Set globbing so this can be recursive
shopt -s globstar;

for i in $dir/**/*.mkv; do
    printf "Attempting $i\n" >> $logfile

    ffmpeg -i "$i" -codec copy -movflags +faststart "${i%.*}.mp4"

    #if unsuccessful - mp4 version may still exist but it might not have fully converted. It wont delete the original or the new file
    if [[ $? -gt 0 ]]; then
        printf "[-]Conversion Failed - verify manually\n\n" >> $logfile
    else
    # if successful - delete the mkv. (backup before in case something is broken)
        rm "$i"
        printf "[+]looks good deleting $i\n\n" >> $logfile
    fi
done

