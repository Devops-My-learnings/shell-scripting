#!/bin/bash

###################################################################################
## Author: Parthiban Sakthivel                                                   ##
## Date: 14/01/2024                                                              ##
## Description: This script will display the repository names for the given user ##
## Version: v1                                                                   ##
###################################################################################

# variable declartion starts here
GITHUB_API="https://api.github.com"

#consume github username & token
GITHUB_USERNAME=$username
GITHUB_TOKEN=$token

#function to connect the github api
connect_API() {
  local endpoints="user/repos"
  local url="${GITHUB_API}/${endpoints}"

  curl -s -u ${GITHUB_USERNAME}:${GITHUB_TOKEN} "$url"
}

listAllReposName() {
 local repoNames="$(connect_API | jq -r '.[].name')"
 echo "Repo Name's :" 
 echo "$repoNames"
}

#script execution
listAllReposName
