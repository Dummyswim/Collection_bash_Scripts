#!/bin/bash

FILE=HOST_LIST.txt
FILE_PATH=/Users/bchavdi/Documents/Personal_Doc/pendirve/files/Nslookup
DNS_HOST=172.29.131.60
OUTPUT_FILE=LOOKUP_RESULT.txt
declare -a appArray
export HOST_NAME
i=0
#num=`cat $FILE | wc -l`
# Populate the array with each element of the file
while read line
do
#	echo "i = $i"
#	echo "line = $line"
	appArray[$i]=$line
#	echo "appArray row = ${appArray[$i]}"
	((i++))
done < $FILE_PATH/$FILE
len=${#appArray[*]}
#echo $len
j=0
echo "" > $FILE_PATH/$OUTPUT_FILE
while [ $j -lt $len ]; do
	IP=`nslookup ${appArray[$j]} $DNS_HOST | grep Address | sed 1d | sort | awk '{print $2}'`
	echo ${appArray[$j]},$IP >> $FILE_PATH/$OUTPUT_FILE
#	echo "";
    let j++
done
cat $FILE_PATH/$OUTPUT_FILE
