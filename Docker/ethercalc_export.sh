#!/bin/sh

echo "running export script" > exportlog.txt
echo "running export script" > ethercalc_saved.txt
# export worksheet to file
#curl --include 'http://localhost:8000/galaxy.csv' > ethercalc_saved.csv


# send to galaxy
python /usr/bin/galaxy.py --action put --argument ethercalc_saved.csv
