#!/bin/bash
WORK_BUCKET=build.394277782245.ap-southeast-2.cosight.com.au
BRAND="all"
ENV_NAME=""
PROJECT_NAME=""
if [ -z "$1" ]; then

 echo "Missing Project Name"
 exit 1
else
 PROJECT_NAME="$1"  

fi
if [ -z "$2" ]; then

 echo "Missing project name"
 exit 1
else
 ENV_NAME="$2"
fi
if [ -z "$3" ]; then

 echo "Missing Brand. using default (all)"

else
 BRAND="$3"

fi

STACK_NAME="${PROJECT_NAME}-${ENV_NAME}-${BRAND}"



#DONT CHANGE
echo pre-deploy step..
OUTPUT_TEMPLATE_FILE="/tmp/SamDeploymentTemplate.`date "+%s"`.yaml"
aws cloudformation package --template-file template.yaml --s3-bucket $WORK_BUCKET --output-template-file "$OUTPUT_TEMPLATE_FILE"

echo deploy
aws cloudformation deploy --template-file "$OUTPUT_TEMPLATE_FILE" --stack-name $STACK_NAME --s3-bucket $WORK_BUCKET    --capabilities CAPABILITY_IAM $PARAMETER_OVERRIDES
rm "$OUTPUT_TEMPLATE_FILE"





