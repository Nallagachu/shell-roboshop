#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"  # Replace with your AMI ID
SG_ID="sg-090f025cfbd817fa8"     # Replace with your SG ID
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z062034323LY47ZYOC2ZR"  # Replace with your Zone ID
DOMAIN_NAME="saijyo.store"       # Replace with your domain

for instance in "${INSTANCES[@]}"; do
    INSTANCE_ID=$(aws ec2 run-instances --image-id "$AMI_ID" --instance-type t3.micro --security-group-ids "$SG_ID" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" --query "Instances[0].InstanceId" --output text)

    if [ -z "$INSTANCE_ID" ]; then
        echo "Failed to create $instance. Skipping..."
        continue
    fi

    if [ "$instance" != "frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
    fi

    echo "$instance IP address: $IP"

    aws route53 change-resource-record-sets --hosted-zone-id "$ZONE_ID" --change-batch "
    {
        \"Comment\": \"Creating or Updating a record set for $instance\",
        \"Changes\": [{
            \"Action\": \"UPSERT\",
            \"ResourceRecordSet\": {
                \"Name\": \"$instance.$DOMAIN_NAME\",
                \"Type\": \"A\",
                \"TTL\": 60,
                \"ResourceRecords\": [{ \"Value\": \"$IP\" }]
            }
        }]
    }"
done
    