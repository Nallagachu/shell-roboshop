#!/bin/bash

# Colors
R="\e[31m"  # Red
G="\e[32m"  # Green
Y="\e[33m"  # Yellow
N="\e[0m"   # Reset

# Setup logs directory and file
LOGS_FOLDER="$HOME/trail_braking_logs"
mkdir -p "$LOGS_FOLDER"
LOG_FILE="$LOGS_FOLDER/trail_braking_$(date +%Y%m%d_%H%M%S).log"

# Start logging
echo -e "${G}Trail Braking Explainer Script Started at $(date)${N}" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

echo -e "${G}Welcome to the Trail Braking Explainer!${N}" | tee -a "$LOG_FILE"
echo -e "${Y}Trail braking is a technique used to smoothly reduce speed while entering a corner by gradually releasing the front brake.${N}" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Prompt user for inputs and log them
read -p "Enter your speed before the corner (km/h): " speed
echo "Speed entered: $speed km/h" | tee -a "$LOG_FILE"

read -p "Enter braking pressure percentage (0-100): " brake
echo "Brake pressure entered: $brake%" | tee -a "$LOG_FILE"

read -p "Enter lean angle in degrees (0-45): " lean
echo "Lean angle entered: $lean degrees" | tee -a "$LOG_FILE"

echo "" | tee -a "$LOG_FILE"

# Logic to provide feedback based on inputs
if [ $brake -gt 70 ] && [ $lean -gt 30 ]; then
  msg="${R}Warning: Too much brake while leaning too much! Risk of front wheel lock or loss of traction.${N}"
elif [ $brake -le 70 ] && [ $lean -gt 30 ]; then
  msg="${G}Good trail braking! You are balancing brake pressure with lean angle.${N}"
elif [ $brake -le 30 ] && [ $lean -lt 15 ]; then
  msg="${Y}You might be under braking; consider applying a bit more brake to control speed safely.${N}"
else
  msg="${Y}Keep practicing to find the smooth balance between braking and leaning.${N}"
fi

# Display and log the feedback message
echo -e "$msg" | tee -a "$LOG_FILE"

echo "" | tee -a "$LOG_FILE"
echo -e "${G}Remember: Trail braking helps maintain control during corner entry by modulating the brake pressure.${N}" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo -e "${G}Script ended at $(date)${N}" | tee -a "$LOG_FILE"
