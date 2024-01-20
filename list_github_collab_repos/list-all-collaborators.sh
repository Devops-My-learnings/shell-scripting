#!/bin/bash
#
###################################################################################################################
# Author: Parthiban Sakthivel                                                                                    ##
# Description: This script will return the collaborators in the given organization/repository to the user        ##
# Date: 07/01/2024                                                                                               ##
# Version: v1                                                                                                    ##
###################################################################################################################
#
# Variable declaration
API="https://api.github.com"

#get github username & token to access the github api
userName=$username
githubToken=$token

#get organization name & repository name in cmd args
orgName=$1
repoName=$2

#function to check the cmd line args
cmdArgs=$#

help() {
 if [ $cmdArgs -ne 2 ]
 then
    echo "The $0 script requires Organization Name & Repository Name to view the collaborators..."
    exit
 fi
}
#function to connect github api
constructAPIcall() {
  local endpoint="repos/${orgName}/${repoName}/collaborators"
  local url="${API}/${endpoint}"

# request github by using curl command
  curl -s -u ${userName}:${githubToken} ${url}
}

#function to list all the collaborators
list_all_users() {
  collaborators="$(constructAPIcall | jq -r '.[] | select(.permissions.pull == true) | .login')"
  echo "$collaborators"
}

#script execution
help
list_all_users
