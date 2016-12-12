#!/bin/bash

SUBDOMAIN_NAME=$1

# get branch name from git if not provided
if [ "$#" -lt 2 ]; then
    BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
else
    BRANCH_NAME=$2
fi

SERVICE_NAME="api-mock-service-${SUBDOMAIN_NAME}"
IMAGE_VERSION="${BRANCH_NAME}"
TASK_FAMILY="api-mock-${SUBDOMAIN_NAME}"

set -x
# Create a new task definition for this build
mkdir -p build
sed -e "s/%BRANCH_NAME%/${BRANCH_NAME}/g" deploy/ecs_task.json > build/ecs_task_${SUBDOMAIN_NAME}.json
sed -i -e "s/%SUBDOMAIN_NAME%/${SUBDOMAIN_NAME}/g" build/ecs_task_${SUBDOMAIN_NAME}.json
aws ecs register-task-definition --family ${TASK_FAMILY} --cli-input-json file://build/ecs_task_${SUBDOMAIN_NAME}.json

# Update the service with the new task definition and desired count
TASK_REVISION=`aws ecs describe-task-definition --task-definition ${TASK_FAMILY} | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/"$//'`
DESIRED_COUNT=`aws ecs describe-services --cluster parku-staging-cluster --services ${SERVICE_NAME} | egrep -m 1 "desiredCount" | tr "/" " " | awk '{print $2}' | sed 's/,$//'`
if [[ ${DESIRED_COUNT} = "0" ]]; then
    DESIRED_COUNT="1"
fi

aws ecs create-service --cluster parku-staging-cluster --service-name ${SERVICE_NAME} --task-definition ${TASK_FAMILY} --desired-count 0
aws ecs update-service --cluster parku-staging-cluster --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count 1
set +x
