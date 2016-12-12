#!/bin/bash
SERVICE_NAME="api-mock-service"
BRANCH_NAME=$1
IMAGE_VERSION="${BRANCH_NAME}"
TASK_FAMILY="api-mock"
set -x
# Create a new task definition for this build
sed -e "s/%BRANCH_NAME%/${BRANCH_NAME}/g" deploy/ecs_task.json > build/ecs_task_${BRANCH_NAME}.json
aws ecs register-task-definition --family ${TASK_FAMILY} --cli-input-json file://build/ecs_task_${BRANCH_NAME}.json

Update the service with the new task definition and desired count
TASK_REVISION=`aws ecs describe-task-definition --task-definition api-mock | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/"$//'`
DESIRED_COUNT=`aws ecs describe-services --cluster parku-staging-cluster --services ${SERVICE_NAME} | egrep -m 1 "desiredCount" | tr "/" " " | awk '{print $2}' | sed 's/,$//'`
if [[ ${DESIRED_COUNT} = "0" ]]; then
    DESIRED_COUNT="1"
fi

aws ecs run-task --cluster parku-staging-cluster --task-definition ${TASK_FAMILY}:${TASK_REVISION}
#aws ecs create-service --cluster parku-staging-cluster --service-name api-mock-service --task-definition api-mock --load-balancers targetGroupArn=arn:aws:elasticloadbalancing:eu-central-1:715994263731:targetgroup/api-mock-targetgroup/b48d1837802f281d,containerName=api-mock-${BRANCH_NAME},containerPort=5000 --role ecsServiceRole --desired-count 0
#aws ecs update-service --cluster parku-staging-cluster --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --load-balancers targetGroupArn=arn:aws:elasticloadbalancing:eu-central-1:715994263731:targetgroup/api-mock-targetgroup/b48d1837802f281d,containerName=api-mock-${BRANCH_NAME},containerPort=5000 --role ecsServiceRole --desired-count 1
set +x
