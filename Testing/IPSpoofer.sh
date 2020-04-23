#!/bin/bash

echo "Welcome, This Script is intend for the use by personnels for IP Aliasing"

echo "Authored By : Pranjal Gupta"

echo "Please Note, the aliased IP addresses will remain in  the system untill the system is powered-on, once closed the IP addresses will be destroyed"

echo "Step 1: Fetching the Network Interface currently In Use"

NTWRKINTRFACE=$(ip route get 8.8.8.8 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')

echo "Step 2: Fetching the attested IP address to the Network Interface"
NETWRKIP=$(ip addr show "$NTWRKINTRFACE" | grep "inet " | cut -d '/' -f1 | cut -d ' ' -f6)

echo $NETWRKIP

echo "Step 3: Grab the Last Octet of the IP Address"
lastOct=$(echo $NETWRKIP | awk -F '.' '{ print $4}')

previousOcts=$(echo $NETWRKIP | awk -F '.' '{print $1"."$2"."$3"."}')

echo "Step 5: Enter sudo root user password"
read -s -p "Enter your sudo password: " pwd

echo "Accept the no of IP aliases the user wants to create"
read -p "Enter the no of aliases you want to create: " n


echo "Step 4: Run an incremental Loop with IP creation command"

# i=0
# while [ "$i" -lt "$n" ];
for(( i = 0; i < n; i++));do
newOct=$(echo "$((lastOct+i+1))")
# echo "New add $newOct"
newIP="$previousOcts$newOct"
# echo "$newIP"
echo $pwd | sudo -S ifconfig $NTWRKINTRFACE:$i $newIP up
echo "$newIP" >>SpoofedIPs.csv
done
#ifconfig -a


