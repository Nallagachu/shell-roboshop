#!/bin/bash

# Colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FILE="/tmp/trail_braking_awareness.log"

echo -e "${Y}===== Trail Braking Awareness Script =====${N}" | tee $LOG_FILE

echo "This script demonstrates:"
echo "- Using variables and colors"
echo "- Using functions to validate steps"
echo "- Taking user input"
echo "- Logging output"
echo | tee -a $LOG_FILE

# Function to simulate awareness message
awareness_msg(){
    local msg=$1
    echo -e "${G}* $msg${N}" | tee -a $LOG_FILE
}

echo -en "${Y}Do you want to learn about trail braking? (yes/no): ${N}"
read answer

if [[ "$answer" =~ ^[Yy] ]]; then
    awareness_msg "Trail braking is a motorcycle riding technique used to maintain control and balance while cornering."
    awareness_msg "It involves carefully releasing the front brake while entering a turn."
    awareness_msg "Proper trail braking improves safety and riding performance."
else
    echo -e "${R}You chose not to learn about trail braking.${N}" | tee -a $LOG_FILE
fi

echo -e "\n${Y}Thank you for running this script!${N}" | tee -a $LOG_FILE
echo -e "Log saved at: $LOG_FILE"
