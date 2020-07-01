#!/bin/bash
# Use this file to merge PDFs. You need ghostscript installed which this checks for
# To convert all files into a specific page size you need pdfjam installed
# Examples: 
#          Basic Use -                           ./mergePDF.sh outputFile.pdf input1.pdf <input2> <input3...>
#          All pdfs in folder -                  ./mergePDF.sh outputFile.pdf *.pdf 


outfile=$1
infile=${*:2}
args=$@
numArgs=$# 

printf "$outfile $infile"
# Check if GhostScipt exists
 which gs >2
if [[ $? -ne 0 ]];then
    printf "GhostScript doesnt seem to be installed. Install it and try again\n"
    exit 1
else
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=$outfile $infile
fi

