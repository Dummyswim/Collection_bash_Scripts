#!/bin/bash
set -x
#logfile="/tmp/pkg.log"
#pkg="dpkg-query --show | awk '{ print $1 }' >> /tmp/pkg.log"
logfile="/root/pkg_coll/pkg.txt"
script="/root/pkg_coll/dpkg-list.sh"
filename="file.txt"
#pkg="dpkg-query --show | awk '{ print $1 }' >> /tmp/pkg.log"

while read line; do
     # < /dev/null is important here to make sure that ssh should not read from stdin as input.
     sshpass -p "Goal1$" scp -r -p $logfile $script bchavdi@$line:/tmp
     ssh -q "$line" "bash -s" < ./tmp/dpkg-list.sh
done < $filename
