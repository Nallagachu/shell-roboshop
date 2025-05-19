#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
C="\e[36m"
N="\e[0m"
LOG_FILE="/tmp/trail_braking_awareness.log"
clear

echo -e "$C========== Trail Braking Awareness ==========$N"
echo -e "Welcome, rider! This script will help you understand the concept of trail braking." | tee -a $LOG_FILE

echo
echo -e "$Y Do you know what trail braking is? (yes/no): $N"
read answer

if [[ "$answer" =~ ^[Nn] ]]
then
  echo -e "$G Trail braking is a technique where you continue to apply the brakes while entering a corner... $N" | tee -a $LOG_FILE
  sleep 2
  echo -e "$C It helps to: \n - Control speed \n - Increase front tire grip \n - Adjust line mid-corner $N" | tee -a $LOG_FILE
else
  echo -e "$G Great! Let's reinforce the importance with some scenarios... $N" | tee -a $LOG_FILE
fi

echo
echo -e "$Y Scenario 1: You're approaching a tight corner too fast... $N"
sleep 2
echo -e "$C Applying light brakes while leaning in = safer turn with more control $N"
sleep 2

echo
echo -e "$Y Scenario 2: Mid-turn, a patch of gravel appears! $N"
sleep 2
echo -e "$R Sudden braking could cause a crash... $N"
sleep 1
echo -e "$G But if you're already trail braking, you’re more stable and can respond better. $N"
sleep 2

echo
echo -e "$C✅ Trail braking improves control and safety. $N" | tee -a $LOG_FILE

echo -e "\nWould you like to test your awareness with a quick quiz? (yes/no):"
read quiz

if [[ "$quiz" =~ ^[Yy] ]]
then
  echo -e "$Y Question: Should you abruptly grab the front brake mid-corner? (yes/no): $N"
  read q1
  if [[ "$q1" =~ ^[Nn] ]]; then
    echo -e "$G Correct! Sudden braking mid-turn can cause loss of traction. $N"
  else
    echo -e "$R Incorrect. Smooth, controlled braking is key! $N"
  fi
fi

echo -e "$C Thank you for spreading awareness on trail braking. Ride safe! 🏍️ $N"
