#!/bin/bash

set -x

# REQUIRED VARIABLES LIST
ACCOUNT_ID=$1
ORG_ID=$2
STUDENT_PROJECT=$3
PAT=$4
DEL_NAME=instruqt-${STUDENT_PROJECT}-$(( $RANDOM % 999999 + 1 ))d
DEL_TOKEN=del-token-${STUDENT_PROJECT}d
DEL_YAML_FILE=harness-delegate.yaml


# GABS REQUIREMENTS
# Check if kubectl is installed
if ! kubectl version --client; then
    echo "kubectl is not installed"
    exit 1
fi
# Set the kubeconfig - if u want to
#KUBECONFIG_PATH="/path/to/kubeconfig"


# Script logic here
#echo "Deploying Harness Delegate named ${DEL_NAME}"

# Gabs hack to send the random delegate name variable as output
# Output in JSON format
echo "{\"delegate_name\": \"$DEL_NAME\"}" > helper.json


# Create Delegate Token
#echo "Im trying to create a Delegate Token for the specific Project"

#result=$(curl -s --location --header 'Content-Length: 0' --header 'x-api-key: '$PAT'' --request POST "https://app.harness.io/gateway/ng/api/delegate-token-ng?accountIdentifier="$ACCOUNT_ID"&orgIdentifier="$ORG_ID"&projectIdentifier="$STUDENT_PROJECT"&tokenName="$DEL_TOKEN | jq ".resource.status" )
#
##echo $result
#
## checking if the Delegate Token was created. The current response is "ACTIVE", but Im not crazy to create this dependency, since this may change.
#if [ $result != "null" ]; then
#    echo "The $del_token was created successfully"
#else
#    echo "Failed to create the Delegate Token!"
#    exit 1
#fi


# Now comes the critical part, where we get their Delegate YAML


del_yaml=$(curl -s -X POST \
  "https://app.harness.io/gateway/ng/api/download-delegates/kubernetes?accountIdentifier="$ACCOUNT_ID"&orgIdentifier="$ORG_ID"&projectIdentifier="$STUDENT_PROJECT"" \
  -H 'Content-Type: application/json' \
  -H 'x-api-key: '$PAT'' \
  -d '{
    "name": "'$DEL_NAME'",
    "description": "The Delegate for the Instruqt Lab",
    "size": "LAPTOP",
    "tags": [
      "string"
    ],
    "clusterPermissionType": "CLUSTER_ADMIN"
  }')

echo "$del_yaml" > $DEL_YAML_FILE
echo "{\"delegate_name\": \"$DEL_NAME\"}" > helper.json
sleep 1
kubectl apply -f $DEL_YAML_FILE