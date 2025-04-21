#!/bin/bash

# Define color variables
BLACK_TEXT=$'\033[0;90m'
RED_TEXT=$'\033[0;91m'
GREEN_TEXT=$'\033[0;92m'
YELLOW_TEXT=$'\033[0;93m'
BLUE_TEXT=$'\033[0;94m'
MAGENTA_TEXT=$'\033[0;95m'
CYAN_TEXT=$'\033[0;96m'
WHITE_TEXT=$'\033[0;97m'

NO_COLOR=$'\033[0m'
RESET_FORMAT=$'\033[0m'
BOLD_TEXT=$'\033[1m'
UNDERLINE_TEXT=$'\033[4m'

# Clear the screen
clear


# Instruction for authentication
gcloud auth list

# Instruction for enabling services

gcloud services enable run.googleapis.com

gcloud services enable cloudfunctions.googleapis.com

# Instruction for setting zone

export ZONE=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-zone])")
gcloud config set compute/zone "$ZONE"

# Instruction for setting region

export REGION=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-region])")
gcloud config set compute/region "$REGION"

# Instruction for downloading sample code

curl -LO https://github.com/GoogleCloudPlatform/golang-samples/archive/main.zip

unzip main.zip

cd golang-samples-main/functions/codelabs/gopher

# Instruction for deploying the first function

deploy_function() {
 gcloud functions deploy HelloWorld --gen2 --runtime go121 --trigger-http --region $REGION --quiet
}

deploy_success=false

while [ "$deploy_success" = false ]; do
  if deploy_function; then
    echo ""
    deploy_success=true
  else
    echo "${RED_TEXT}${BOLD_TEXT}Deployment failed. Retrying in 10 seconds...${RESET_FORMAT}"
    echo "${YELLOW_TEXT}${BOLD_TEXT}Meanwhile subscribe to QwikLab Explorers! ${RESET_FORMAT}"
    sleep 10
  fi
done

# Instruction for deploying the second function

deploy_function() {
 gcloud functions deploy Gopher --gen2 --runtime go121 --trigger-http --region $REGION --quiet
}

deploy_success=false

while [ "$deploy_success" = false ]; do
  if deploy_function; then
    echo ""
    deploy_success=true
  else
    echo "${RED_TEXT}${BOLD_TEXT}Deployment failed. Retrying in 10 seconds...${RESET_FORMAT}"
    echo "${YELLOW_TEXT}${BOLD_TEXT}Meanwhile subscribe to QwikLab Explorers! ${RESET_FORMAT}"
    sleep 10
  fi
done


echo -e "${RED_TEXT}${BOLD_TEXT}Subscribe my Channel (QwikLab Explorers):${RESET_FORMAT} ${BLUE_TEXT}${BOLD_TEXT}https://www.youtube.com/@qwiklabexplorers${RESET_FORMAT}"
echo
