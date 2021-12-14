#!/bin/bash

# author: 2021-12-08 shawn.becker@angel.com

export WORK_DIR=~/workspace-angel
export PROJECT_DIR=$WORK_DIR/RetrievePowerAndPerformanceMetricsAndLogInsights

cd ${PROJECT_DIR}
source .env

export OPEN_API_FILE_NAME=app-store-connect-openapi-specification
export API_COLLECTION_FILE_NAME=app-store-connect-api-collection
export DEV_BASE_URL=https://developer.apple.com/sample-code/app-store-connect
export OPEN_API_ZIP_SOURCE_URL=${DEV_BASE_URL}/${OPEN_API_FILENAME}.zip

# download the api zip file
cd ~/Downloads
curl $API_ZIP_SOURCE_URL -o ${OPEN_API_FILENAME}.zip

# unzip the api zipfile to get ${API_FILENAME}.json
unzip ${OPEN_API_FILENAME}.zip

# install the openapi-to-postmanv2 node package globally
npm i -g openapi-to-postmanv2

# convert the OpenAPIv3 json file to Postmanv2 API collection file
cd ${PROJECT_DIR}
mkdir -p api
openapi2postmanv2 -s ~/Downloads/${OPEN_API_FILENAME}.json -o api/${API_COLLECTION_FILE_NAME}.json -p -O folderStrategy=Tags,includeAuthInfoInExample=false

echo "in Postman import ${PROJECT_DIR}/api/${API_COLLECTION_FILE_NAME}.json to create a new collection named 'App Store Connect API'"



