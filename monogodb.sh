#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/logs/roboshops-logs"
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1) 
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p "$LOGS_FOLDER"
echo "script started time at : $(date)" &>> | tee -a $LOG_FILE
if [ "$USERID" -ne 0 ]; then
    echo -e "$R ERROR:: Please run this script with root access $N" &>> | tee -a $LOG_FILE
    exit 1 # Give other than 0 up to 127
else
    echo "You are running with root access" &>> | tee -a $LOG_FILE
fi
# Validate function takes input as exit status, what command they tried to install
VALIDATE(){
    if [ "$1" -eq 0 ]; then
        echo -e "Installing $2 is ... $G SUCCESS $N" &>> | tee -a $LOG_FILE
    else
        echo -e "Installing $2 is ... $R FAILURE $N" &>> | tee -a $LOG_FILE
        exit 1
    fi
}

 cp mongo.repo /etc/yum.repos.d/mongodb.repo &>> | tee -a $LOG_FILE
 dnf install mongodb-org -y 
 
 VALIDATE $? "Installing mongodb server"
    systemctl enable mongod 
    VALIDATE $? "enabling mongodb"

 
    systemctl start mongod
    VALIDATE $? "Starting mongogb"

sed -i 's/127.0.0.1/0.0.0.0' /etc/mongod.conf

VALIDATE $? "Editing monogdb config file  for remote access to other server "

    systemctl restart mongod
    VALIDATE $? "Restarting mongodb"
 
    echo -e "$G MongoDB is installed and running successfully $N" &>> | tee -a $LOG_FILE