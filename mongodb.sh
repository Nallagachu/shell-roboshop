#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/roboshops-logs"  # Fixed log path (standard Linux convention)
SCRIPT_NAME=$(basename "$0" | cut -d "." -f1) 
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p "$LOGS_FOLDER"
echo "script started time at : $(date)" | tee -a "$LOG_FILE"

if [ "$USERID" -ne 0 ]; then
    echo -e "$R ERROR:: Please run this script with root access $N" | tee -a "$LOG_FILE"
    exit 1
else
    echo "You are running with root access" | tee -a "$LOG_FILE"
fi

# Validate function takes input as exit status, what command they tried to install
VALIDATE(){
    if [ "$1" -eq 0 ]; then
        echo -e "Installing $2 is ... $G SUCCESS $N" | tee -a "$LOG_FILE"
    else
        echo -e "Installing $2 is ... $R FAILURE $N" | tee -a "$LOG_FILE"
        exit 1
    fi
}

cp mongo.repo /etc/yum.repos.d/mongodb.repo 2>&1 | tee -a "$LOG_FILE"
dnf install mongodb-org -y 2>&1 | tee -a "$LOG_FILE"

VALIDATE $? "Installing MongoDB server"

systemctl enable mongod 2>&1 | tee -a "$LOG_FILE"
VALIDATE $? "Enabling MongoDB"

systemctl start mongod 2>&1 | tee -a "$LOG_FILE"
VALIDATE $? "Starting MongoDB"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf 2>&1 | tee -a "$LOG_FILE"
VALIDATE $? "Editing MongoDB config file for remote access"

systemctl restart mongod 2>&1 | tee -a "$LOG_FILE"
VALIDATE $? "Restarting MongoDB"

echo -e "$G MongoDB is installed and running successfully $N" | tee -a "$LOG_FILE"
