#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0764771bbfa5c15f9" # replace with your SG ID

for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids sg-0764771bbfa5c15f9 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)


    #Get private ip
    if [ $instance != "frontend" ]; then
       IP=$(aws ec2 describe-instances --instance-ids i-0a022bee972696a59 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)

    else
        IP=$(aws ec2 describe-instances --instance-ids i-0a022bee972696a59 --query 'Reservations[0].Instances[0].Public
        IpAddress' --output text)

    fi

    echo $instance: $IP
done

