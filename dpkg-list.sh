#!/bin/bash

logfile="/tmp/pkgList.log"
pkgfile="/tmp/pkg.txt"
#cmd="cat /etc/juniper.facts | grep passwd_file | awk -F '=' '{print $2}'"
cmd="$(grep '^bchavdi' /etc/passwd | awk -F : '{ print $1}')"
#cmd="$(grep '^passwd_file' /etc/juniper.facts | awk -F = '{ print $2}')"
pkg="$(dpkg-query --show | awk '{ print $1 }' >> /tmp/pkgList.log)"
strfound=0
strNotfound=0
$pkg
while read -r line; do

  if grep -wqF "$line" "$logfile" ;
  then
    let "strfound++"
  else
      let "strNotfound++"
  fi
done < "$pkgfile"

if [ "$strNotfound" -gt 0 ]
then
    echo "Its not UBM  "
else
    echo "$HOSTNAME-$cmd-$strNotfound"
