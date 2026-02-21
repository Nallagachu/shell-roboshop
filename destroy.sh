#!/bin/bash

for instance in $@
do
    echo "Finding instance: $instance"

    INSTANCE_IDS=$(aws ec2 describe-instances \
        --filters "Name=tag:Name,Values=$instance" "Name=instance-state-name,Values=running" \
        --query "Reservations[*].Instances[*].InstanceId" \
        --output text)

    if [[ -z "$INSTANCE_IDS" ]]; then
        echo "No running instance found for $instance"
        continue
    fi

    echo "Terminating instance(s): $INSTANCE_IDS"

    aws ec2 terminate-instances --instance-ids $INSTANCE_IDS

    echo "$instance terminated"
    echo "--------------------------"
done