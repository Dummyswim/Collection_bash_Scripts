#!/bin/bash
# Enable this to see the variable assignment and execution of script in verbose mode
#set -x

filename="file.txt"

# Storing command in vairable and executing it
#com6="$(df -h /b ; df -h /n)"

# Loop through list of hosts
while read -r line; do
    echo "<------------------------------------------------------>"
    echo "Logging to: $line"
    echo " "
    df=`ssh -q "$line" "df -h /b; echo; df -h /; echo; echo;" < /dev/null`
    echo "$df"
done < "$filename"


#     Output
#-----------------------------

# <------------------------------------------------------>
# Logging to: server1.domain.net
#
# Filesystem      Size  Used Avail Use% Mounted on
# /dev/vdb        1.5T  541G  861G  39% /b
#
# Filesystem           Size  Used Avail Use% Mounted on
# /dev/mapper/os-root  4.6G  546M  3.8G  13% /
# <------------------------------------------------------>
# Logging to: server2.domain.net
#
# Filesystem      Size  Used Avail Use% Mounted on
# /dev/vdb        1.5T  969G  433G  70% /b
#
# Filesystem           Size  Used Avail Use% Mounted on
# /dev/mapper/os-root  9.3G  755M  8.1G   9% /
# <------------------------------------------------------>
