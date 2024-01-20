#!/bin/bash

########################################################################################################################
# Author: Parthiban Sakthivel                                                                                         ##
# Date: 01/11/2024                                                                                                    ##
# Description: This script will check the AWS(s3,ec2,iam,lambda) service details and print the details on the console.##
# Version:v1                                                                                                          ##
#######################################################################################################################

#variable declaration
Date=$(date +"%d_%m_%Y_%H_%M_%s")
filename="aws-resource-check_${Date}.log"

#aws s3
echo "AWS s3 service details : "  > $filename
aws s3 ls                       >> $filename
#aws IAM
echo "AWS iam users"     >> $filename
aws iam list-users       >> $filename
#aws ebs
echo "AWS lambda  details : " >> $filename
aws lambda list-functions     >> $filename
#aws ec2
echo "AWS EC2 instance ID details"  >> $filename
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' >> $filename

