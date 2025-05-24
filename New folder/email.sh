#!/bin/bash
[ "$(df / | awk 'NR==2 {print $5}' | tr -d '%')" -gt 90 ] && echo "Disk High!" | msmtp your_email@example.com
# This script checks the disk usage of the root filesystem and sends an email if it exceeds 90%.
# Replace ' 


#!/bin/bash

THRESHOLD=90
EMAIL="your_email@example.com"
USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

[ "$USAGE" -gt "$THRESHOLD" ] && echo -e "Subject: Disk Usage Alert\n\nUsage at $USAGE%" | msmtp $EMAIL
