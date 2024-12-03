#!/bin/bash

# Iterate through all possible IP addresses in the 172.16.17.x subnet
for i in {0..255}; do
  # Define the current IP address
  ip="192.168.37.$i"
  
  # Ping the IP address with a timeout of 1 second (adjustable)
  ping -W 1 -c 1 $ip
  
  # Check the exit status of the ping command
  if [ $? -eq 0 ]; then
    echo "Server $ip is up and running"
  else
    echo "Server $ip is unreachable"
  fi
done
