#!/bin/bash
#set -x

ALERT=60


verification () {
  usep=$(echo $space | awk '{ print $1}' | cut -d'%' -f1)
  partition=$(echo $space | awk '{print $2}')
  host=$(hostname)

  if [ $usep -ge $ALERT ]; then
    if [ $partition == "/b" ]; then
      Message="Your CCP UBM \"$host\" has it’s volume \"$partition\" at \"$usep%\" utilization and we are facing a critical storage capacity issue with it’s backing storage server. Kindly cleanup your volume \"$partition\" asap"
    else
      Message="Your CCP UBM \"$host\" has it’s volume \"$partition\" at \"$usep%\" utilization and we are facing a critical storage capacity issue with it’s backing storage server. Kindly cleanup your volume \"$partition\" and if possible, move all your data from /n to /b and confirm asap, we will detach and delete /n."
    fi
    echo -e '\n------------------------------\n''CCP VM volume - Clean up and recovery''\n'$Message'\n\nThanks,\nBalaji Chavdi \n''\n------------------------------'>> "/homes/bchavdi/diskfile.txt"
  #else
    #Message="Your CCP UBM has it’s volume \"$partition\" at \"$usep%\" utilization. This is looking good"
    #echo -e '\n------------------------------\n'`hostname` '\n'$Message'\n\nThanks,\nBalaji Chavdi \n''\n------------------------------'>> "/homes/bchavdi/diskfile.txt"

  fi


}
### Main script starts here

b_space=`df -h /b | awk '{print $6}' | grep -v Mounted`
n_space=`df -h /n | awk '{print $6}' | grep -v Mounted`


if [ "$n_space" == "/n" ]; then
  # yes
  # do we have /b
  if [ "$b_space" == "/b" ]; then
    # yes
    # That means there are /n and /b
    # then call case with /n value
    #space=`df -h /n | awk '{print $5}' | grep % | grep -v Use | sort -n | tail -1 | cut -d "%" -f1 -`
    space=`df -H /n | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}'`
    verification "$space"
  else # no
  # That means there is only /n
  # then call case with /n value
  space=`df -H /n | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}'`
  verification "$space"
  fi
else # no
  # we have /b only
  # then call case with /b value
  space=`df -H /b | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}'`
  verification "$space"
fi

bspace=`df -h /b | awk '{print $5}' | grep % | grep -v Use | sort -n | tail -1 | cut -d "%" -f1 -`

nspace=`df -h /n | awk '{print $5}' | grep % | grep -v Use | sort -n | tail -1 | cut -d "%" -f1 -`


# message to a file with hostname
