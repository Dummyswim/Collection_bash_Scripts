#!/bin/bash
# Enable this to see the variable assignment and execution of script in verbose mode
#set -x

# File to store hostnames
filename="file.txt"
# Loop through list of hosts and execute command
while read line; do
     # < /dev/null is important here to make sure that ssh should not read from stdin as input.
     ssh -q "$line" "pam_tally2 --user=_cloudmon --reset; echo; echo; "  < /dev/null
done < $filename
