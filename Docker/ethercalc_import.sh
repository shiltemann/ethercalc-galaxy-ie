#!/bin/sh

# wait til ethercalc has started
sleep 2 # TODO: replace with check if actually running

cd /import

# get dataset from galaxy history
get -i ${DATASET_HID}

# create new spreadsheet named galaxy
curl --include \
     --request POST \
     --header "Content-Type: application/json" \
     --data-binary "{ \"room\": \"galaxy\", \"snapshot\": \"...\"}"  \
'http://localhost:8000/_'

# load dataset into worksheet
curl --include --request PUT \
--header "Content-Type: text/csv" \
--data-binary @${DATASET_HID} http://localhost:8000/_/galaxy
