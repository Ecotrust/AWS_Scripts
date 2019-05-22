#!/bin/bash

# Point this at your AWS region
export AWS_DEFAULT_REGION=us-west-2
export AWS_ACCESS_KEY_ID="SET ME"
export AWS_SECRET_ACCESS_KEY="SET ME"
export AWS_VOLUME_ID="SET ME"
export DELETE_AFTER_DAYS=90
# Point this at your venv python: .../env/bin/python
export PYTHON_BIN=python
export PARSE_SCRIPT=parse_snapshots.py

echo
echo ========== BEGIN SNAPSHOT SCRIPT ==========
process=`aws ec2 create-snapshot --volume-id $AWS_VOLUME_ID --description /dev/xvda1`
pid=$(echo $process | perl -nle'print $& if m{"SnapshotId": ".*?[^\\]"}' | sed 's/\"SnapshotId\": \"//g' | sed 's/\"//g')
echo creating snapshot $pid ...
status=`aws ec2 describe-snapshots --snapshot-ids $pid`
pct_done=$(echo $status | perl -nle'print $& if m{"Progress": ".*?[^\\]"}' | sed 's/\"Progress\": \"//g' | sed 's/\%"//g')
while [[ $pct_done != "100" ]]
do
    echo $pct_done% completed...
    sleep 10
    status=`aws ec2 describe-snapshots --snapshot-ids $pid`
    pct_done=$(echo $status | perl -nle'print $& if m{"Progress": ".*?[^\\]"}' | sed 's/\"Progress\": \"//g' | sed 's/\%"//g')
done
echo snapshot $pid completed

snapshots=`aws ec2 describe-snapshots --owner self --output json`

### parse_snapshots.py takes the json list of snapshots and the age at
###     which they are considered to be old in "DAYS"
old_snaps=`$PYTHON_BIN $PARSE_SCRIPT "$snapshots" $DELETE_AFTER_DAYS`
IFS="|" read -a old_array <<< "$old_snaps"

for i in "${old_array[@]}"
  do
    echo ---------------------
    echo DELETING "$i"...
    aws ec2 delete-snapshot --snapshot-id $i
    echo SNAPSHOT "$i" DELETED
  done
echo ========END SNAPSHOT SCRIPT ========
echo
