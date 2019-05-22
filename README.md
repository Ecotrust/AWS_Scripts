# AWS_Scripts
Scripts to help automate managing AWS servers


## Installation
The current scripts are BASH shell scripts written for Linux.

Be sure that they are executable, and then run with ./{scriptname}.sh

Helper scripts were written for python 3.

## Snapshot
 > Requires awscli
 
 > `sudo apt install awscli`
 
 > requires python, relies on script 'parse_snapshots.py'

### Configure:
From your AWS instance you will need:
 * The AWS Region where your instance is housed (i.e. 'us-west-2' for Oregon)
 * Your Access Key ID (often starts like 'AKIA...')
 * Your AWS Secret Access Key (you get this when you create a user)
 * The Volume ID of the EBS volume you wish to back up ('vol-...')
 * (Optional) The number of days of age at which point you wish to delete old backups
    * This is set to 90 by default,

### Run:
Run with `./snapshot.sh`
