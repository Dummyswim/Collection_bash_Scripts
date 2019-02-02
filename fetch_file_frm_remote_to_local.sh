#!/bin/bash
#set -x

filename="hostname.txt"
remote_path="/root/contrail-ubm*.txt"
local_target_dir="/root/pkg_coll/BNG-CCP-C2-UBM/"

# Loop through list of hosts
while read -r line; do
    scp "$line":"$remote_path" "$local_target_dir"
done < "$filename"
