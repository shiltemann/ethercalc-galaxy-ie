#!/bin/bash

cd /import

# get dataset from galaxy history
get -i ${DATASET_HID}

# make sure ethercalc has finished starting up
STATUS=$(curl --include 'http://localhost:8000/_/galaxy' 2>&1)
while [[ ${STATUS} =~ "refused" ]]
do
  echo "waiting for ethercalc: $STATUS \n"
  STATUS=$(curl --include 'http://localhost:8000/_/galaxy' 2>&1)
  sleep 2
done

# create new spreadsheet named galaxy
curl --include \
     --request POST \
     --header "Content-Type: application/json" \
     --data-binary "{ \"room\": \"galaxy\", \"snapshot\": \"...\"}"  \
'http://localhost:8000/_'

# put loading message into worksheet in case of large files
echo -e "Loading your,dataset\nThis may take, some time for, large files.." > loading.txt
curl --include --request PUT --header "Content-Type: text/csv" --data-binary @loading.txt http://localhost:8000/_/galaxy

# remove dump file so this doesnt appear in audit trail
rm /dump.json

# load dataset into worksheet
curl --include --request PUT \
--header "Content-Type: text/csv" \
--data-binary @${DATASET_HID} http://localhost:8000/_/galaxy
