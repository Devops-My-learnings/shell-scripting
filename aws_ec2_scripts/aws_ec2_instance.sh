#!/bin/bash
#
###################################################################################################################
# Author: Parthiban Sakthivel                                                                                    ##
# Description: This script will start, stop, check status of the aws ec2 instance and also get public Ip address ## 
# Date: 18/01/2024                                                                                               ##
# Version: v1                                                                                                    ##
###################################################################################################################
#
# Variable declaration

AWS_INSTANCE_ID=$(aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId')

#function to get aws ec2 instance public Ip address
getIpAddress(){
  PUBLIC_IP_ADDRESS=$(aws ec2 describe-instances | jq -r '.Reservations[].Instances[].PublicIpAddress')
  echo""
  echo "The Public Ip Address is ${PUBLIC_IP_ADDRESS}"
}


# function to start the aws ec2 instances
startEc2Instances() {  
  echo "Starting aws ec2 instance..."
  aws ec2 start-instances --instance-ids $AWS_INSTANCE_ID 
  echo "Fetching aws ec2 instance Ip. Please wait..."
  sleep 20s
  getIpAddress
}

#function to check the ec2 instance state
checkInstanceStatus(){
  INSTANCESTATUS=$(aws ec2 describe-instance-status | jq -r '.InstanceStatuses[].InstanceState.Name')

  if [ -z $INSTANCESTATUS ]; then
     echo "The Ec2 Instance is not in running state. start and check it once."
     exit
  fi

  echo "The Ec2 Instance is currently in ${INSTANCESTATUS} state."
}

#function to stop the ec2 instance
stopInstances() {
  echo "Stopping aws ec2 instances..."
  aws ec2 stop-instances --instance-ids ${AWS_INSTANCE_ID}
}

# Get user Input
echo "The script will start, stop & check status of the aws ec2 instances. select any one option below."
echo "1.start"
echo "2.stop"
echo "3.status"
read userOption

if [ $userOption -eq "1" ]; then
  startEc2Instances
elif [ $userOption -eq "2" ]; then
  stopInstances
elif [ $userOption -eq "3" ]; then
  checkInstanceStatus
else
  echo "Error: Invalid Option. select correct option."
fi

