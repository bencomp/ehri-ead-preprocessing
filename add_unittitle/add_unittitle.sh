#!/bin/bash

# Run Saxon to add 

if [[ "x$1" -eq "x" ]]; then
    echo "You must provide a filename."
    exit 1
fi

java -jar ~/Applications/saxon9he.jar -s:"$1" \
    -xsl:"add_unittitle_to_EAD.xsl" \
    -o:"$1.t.xml" #2> "$1.log"

