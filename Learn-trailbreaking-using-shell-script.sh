#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
C="\e[36m"
N="\e[0m"
LOG_FILE="/tmp/trail_braking_youtube_awareness.log"

echo -e "$C========== Trail Braking Video Awareness ==========$N"
echo -e "$YThis script demonstrates how a shell script can be used to raise awareness about trail braking using real-world YouTube content.$N"
echo -e "We will now open a few short videos in your browser that:\n - Teach the concept\n - Show its practical usage\n - Reflect how it helps in daily riding.\n" | tee -a $LOG_FILE

echo -e "$Y Do you want to continue? (yes/no): $N"
read choice

if [[ "$choice" =~ ^[Yy] ]]; then
    echo -e "$G Opening awareness videos...$N"
    echo "Opened trail braking videos at $(date)" >> $LOG_FILE

    echo -e "\n$C1️⃣ Learn the Concept: What is Trail Braking?$N"
    echo "Video: https://www.youtube.com/watch?v=8d5HbU581sI"
    xdg-open "https://www.youtube.com/watch?v=8d5HbU581sI" &>/dev/null
    sleep 3

    echo -e "\n$C2️⃣ Observe the Application: Why is he trail braking?$N"
    echo "Video: https://www.youtube.com/shorts/8ckd7xMcCiU"
    xdg-open "https://www.youtube.com/shorts/8ckd7xMcCiU" &>/dev/null
    sleep 3

    echo -e "\n$C3️⃣ Realize the Impact: How it helps in daily life.$N"
    echo "Video: https://www.youtube.com/watch?v=8d5HbU581sI"
    xdg-open "https://www.youtube.com/watch?v=8d5HbU581sI" &>/dev/null

    echo -e "\n$G Videos launched successfully. Watch and reflect on how trail braking improves control, safety, and confidence.$N"
else
    echo -e "$R Awareness videos skipped. Remember, knowledge can save lives. Ride safe! 🏍️ $N"
fi
