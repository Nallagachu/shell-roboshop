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

# Redirect all output (stdout and stderr) to tee for logging and console output
exec > >(tee -a "$LOG_FILE") 2>&1

echo -e "${G}Trail Braking Explainer Script Started at $(date)${N}"
echo ""

echo -e "${G}Welcome to the Trail Braking Explainer!${N}"
echo -e "${Y}Trail braking is a technique used to smoothly reduce speed while entering a corner by gradually releasing the front brake.${N}"
echo ""

# Prompt user for inputs (these inputs will also be saved because of exec above)
read -p "Enter your speed before the corner (km/h): " speed
echo "Speed entered: $speed km/h"

read -p "Enter braking pressure percentage (0-100): " brake
echo "Brake pressure entered: $brake%"

read -p "Enter lean angle in degrees (0-45): " lean
echo "Lean angle entered: $lean degrees"
echo ""

# Logic to provide feedback based on inputs
if [ "$brake" -gt 70 ] && [ "$lean" -gt 30 ]; then
  echo -e "${R}Warning: Too much brake while leaning too much! Risk of front wheel lock or loss of traction.${N}"
elif [ "$brake" -le 70 ] && [ "$lean" -gt 30 ]; then
  echo -e "${G}Good trail braking! You are balancing brake pressure with lean angle.${N}"
elif [ "$brake" -le 30 ] && [ "$lean" -lt 15 ]; then
  echo -e "${Y}You might be under braking; consider applying a bit more brake to control speed safely.${N}"
else
  echo -e "${Y}Keep practicing to find the smooth balance between braking and leaning.${N}"
fi

echo ""
echo -e "${G}Remember: Trail braking helps maintain control during corner entry by modulating the brake pressure.${N}"
echo ""
echo -e "${G}Script ended at $(date)${N}"
