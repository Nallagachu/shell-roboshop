#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-090f025cfbd817fa8"
ZONE_ID="Z0958532294CVT5P59JI0"
DOMAIN_NAME="saijyo.store"
for instance in $@
do 
    echo "Creating instance: $instance"

    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id "$AMI_ID" \
        --instance-type t3.micro \
        --security-group-ids "$SG_ID" \
        --associate-public-ip-address \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
        --query "Instances[0].InstanceId" \
        --output text)

    if [[ -z "$INSTANCE_ID" ]]; then
        echo "Failed to create $instance. Skipping..."
        continue
    fi

    echo "Instance ID: $INSTANCE_ID"
    echo "Waiting for instance to enter running state..."

    aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"

    echo "Instance is running. Fetching IP..."

    # Wait until IP is available
    while true; do
        if [[ "$instance" != "frontend" ]]; then
            IP=$(aws ec2 describe-instances \
                --instance-ids "$INSTANCE_ID" \
                --query "Reservations[0].Instances[0].PrivateIpAddress" \
                --output text)
        else
            IP=$(aws ec2 describe-instances \
                --instance-ids "$INSTANCE_ID" \
                --query "Reservations[0].Instances[0].PublicIpAddress" \
                --output text)
        fi

        if [[ "$IP" != "None" && -n "$IP" ]]; then
            break
        fi

        echo "Waiting for IP assignment..."
        sleep 5
    done

    echo "$instance IP address: $IP"

    RECORD_NAME="$instance.$DOMAIN_NAME"

    aws route53 change-resource-record-sets \
    --hosted-zone-id "$ZONE_ID" \
    --change-batch "{
        \"Comment\": \"Creating or Updating record for $instance\",
        \"Changes\": [{
            \"Action\": \"UPSERT\",
            \"ResourceRecordSet\": {
                \"Name\": \"$RECORD_NAME\",
                \"Type\": \"A\",
                \"TTL\": 60,
                \"ResourceRecords\": [{
                    \"Value\": \"$IP\"
                }]
            }
        }]
    }"

    echo "DNS updated for $RECORD_NAME"
    echo "--------------------------------------"
done