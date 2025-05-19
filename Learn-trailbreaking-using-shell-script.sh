#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
C="\e[36m"
N="\e[0m"
LOG_FILE="/tmp/trail_braking_youtube_awareness.log"

# Detect open command based on OS
if command -v xdg-open &>/dev/null; then
    OPEN_CMD="xdg-open"
elif command -v open &>/dev/null; then
    OPEN_CMD="open"
elif [[ "$(uname -o)" == "Msys" || "$(uname -o)" == "Cygwin" ]]; then
    OPEN_CMD="cmd.exe /c start"
else
    echo -e "$R ERROR: Could not detect a browser launch method for your OS. $N"
    exit 1
fi

echo -e "$C========== Trail Braking Video Awareness ==========$N"
echo -e "$YThis script shows how shell scripting can be used for practical awareness using YouTube videos.$N"
echo -e "We'll guide you through:\n - Learning\n - Observing\n - Reflecting\n" | tee -a $LOG_FILE

# Video 1 - Learn
echo -e "\n$C1️⃣ Learn: What is Trail Braking?$N"
echo "Video: https://www.youtube.com/watch?v=8d5HbU581sI"
echo -e "$Y Do you want to open this video? (yes/no): $N"
read ans1
if [[ "$ans1" =~ ^[Yy] ]]; then
    $OPEN_CMD "https://www.youtube.com/watch?v=8d5HbU581sI" &>>$LOG_FILE &
    echo "Opened Learn video at $(date)" >> $LOG_FILE
else
    echo "Skipped Learn video." >> $LOG_FILE
fi

# Video 2 - Think
echo -e "\n$C2️⃣ Think: Why is he trail braking?$N"
echo "Video: https://www.youtube.com/shorts/8ckd7xMcCiU"
echo -e "$Y Do you want to open this video? (yes/no): $N"
read ans2
if [[ "$ans2" =~ ^[Yy] ]]; then
    $OPEN_CMD "https://www.youtube.com/shorts/8ckd7xMcCiU" &>>$LOG_FILE &
    echo "Opened Think video at $(date)" >> $LOG_FILE
else
    echo "Skipped
