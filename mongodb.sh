#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/logs/roboshops-logs"
SCRIPT_NAME=$(basename "$0" | cut -d "." -f1) 
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p "$LOGS_FOLDER"
echo "script started time at : $(date)" | tee -a |  tee -a $LOG_FILE

if [ "$USERID" -ne 0 ]; then
    echo -e "$R ERROR:: Please run this script with root access $N" | tee -a |  tee -a $LOG_FILE
    exit 1
else
    echo "You are running with root access" | tee -a |  tee -a $LOG_FILE
fi

# Validate function takes input as exit status, what command they tried to install
VALIDATE(){
    if [ "$1" -eq 0 ]; then
        echo -e "Installing $2 is ... $G SUCCESS $N" | tee -a |  tee -a $LOG_FILE
    else
        echo -e "Installing $2 is ... $R FAILURE $N" | tee -a |  tee -a $LOG_FILE
        exit 1
    fi
}

cp mongo.repo /etc/yum.repos.d/mongodb.repo &>> |  tee -a $LOG_FILE
dnf install mongodb-org -y &>> |  tee -a $LOG_FILE

VALIDATE $? "Installing mongodb server"
systemctl enable mongod &>> |  tee -a $LOG_FILE
VALIDATE $? "Enabling mongodb"

systemctl start mongod &>> |  tee -a $LOG_FILE
VALIDATE $? "Starting mongodb"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
VALIDATE $? "Editing mongodb config file for remote access"

systemctl restart mongod &>> |  tee -a $LOG_FILE
VALIDATE $? "Restarting mongodb"

echo -e "$G MongoDB is installed and running successfully $N" | tee -a |  tee -a $LOG_FILE
