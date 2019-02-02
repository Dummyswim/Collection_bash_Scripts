#!/bin/bash
# Enable this to see the variable assignment and execution of script in verbose mode
#set -x

filename="file.txt"

# Storing command in vairable and executing it
com1="$(df -h /b | awk '{$1=""; print $0}')"
com2="$(df -h /n | awk '{$1=""; print $0}')"

# Different way of storing command in vairable and executing it
#com1 = `df -h | grep $g1 | awk '{ print $0}'`
#com2 = `df -h | grep $g2 | awk '{$1=""; print $0}'`

# Loop through list of hosts
while read -r line; do
     echo "Logging to: $line"
     ssh -q $line "$com1";
     ssh -q $line "$com2";
done < "$filename"
