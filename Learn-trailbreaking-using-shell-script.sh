#!/bin/bash

# Define color codes
R="\e[31m"  # Red
G="\e[32m"  # Green
Y="\e[33m"  # Yellow
C="\e[36m"  # Cyan
N="\e[0m"   # Reset

# Log file location
LOG_FILE="/tmp/trail_braking_youtube_awareness.log"

# Check if xdg-open is available
if ! command -v xdg-open &>/dev/null; then
    echo -e "$R ERROR: 'xdg-open' is not available. Please install it with:$N"
    echo -e "$Y sudo apt install xdg-utils $N  (for Debian/Ubuntu)"
    echo -e "$Y sudo dnf install xdg-utils $N  (for Fedora/RHEL)"
    exit 1
fi

# Welcome
echo -e "$C========== Trail Braking Awareness Script ==========$N"
echo -e "$YUsing Linux shell scripting to raise awareness on motorcycle trail braking through real videos.$N"
echo -e "Topic: Trail Braking - Learn, Observe, and Reflect\n" | tee -a $LOG_FILE

# Ask user before opening each video
# 1. Learn
echo -e "$C1️⃣ Learn the Concept: What is Trail Braking?$N"
echo "Video: https://www.youtube.com/watch?v=8d5HbU581sI"
read -p "$(echo -e $Y'Would you like to open this video? (yes/no): '$N)" ans1
if [[ "$ans1" =~ ^[Yy] ]]; then
    xdg-open "https://www.youtube.com/watch?v=8d5HbU581sI" &>>$LOG_FILE &
    echo "Opened 'Learn' video at $(date)" >> $LOG_FILE
else
    echo "Skipped 'Learn' video." >> $LOG_FILE
fi

# 2. Think
echo -e "\n$C2️⃣ Think: Why is he using trail braking?$N"
echo "Video: https://www.youtube.com/shorts/8ckd7xMcCiU"
read -p "$(echo -e $Y'Would you like to open this video? (yes/no): '$N)" ans2
if [[ "$ans2" =~ ^[Yy] ]]; then
    xdg-open "https://www.youtube.com/shorts/8ckd7xMcCiU" &>>$LOG_FILE &
    echo "Opened 'Think' video at $(date)" >> $LOG_FILE
else
    echo "Skipped 'Think' video." >> $LOG_FILE
fi

# 3. Realize
echo -e "\n$C3️⃣ Realize: How trail braking helps in daily riding.$N"
echo "Video: https://www.youtube.com/watch?v=8d5HbU581sI"
read -p "$(echo -e $Y'Would you like to open this video? (yes/no): '$N)" ans3
if [[ "$ans3" =~ ^[Yy] ]]; then
    xdg-open "https://www.youtube.com/watch?v=8d5HbU581sI" &>>$LOG_FILE &
    echo "Opened 'Realize' video at $(date)" >> $LOG_FILE
else
    echo "Skipped 'Realize' video." >> $LOG_FILE
fi

# Closing message
echo -e "\n$G✅ Done! You've used shell scripting to educate through video-based learning.$N"
echo -e "$C(Log file saved to: $LOG_FILE)$N"
