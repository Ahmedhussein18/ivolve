#!/bin/bash

# Set the threshold (in percentage)
THRESHOLD=10

# Get the disk usage of the root file system
USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

# Check if usage exceeds the threshold
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "sending mail"	
    echo -e "Subject: Disk Space Alert\n\nDisk usage on the root file system is above the threshold." | msmtp --from=default -t ahmed.marzoukk00@gmail.com

fi

