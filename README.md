# AWS_Scripts
Scripts to help automate managing AWS servers


## Installation
### Bash
The current scripts are BASH shell scripts written for Linux.

Be sure that they are executable, and then run with ./{scriptname}.sh

### Postfix/Cron Jobs
Cron jobs like to communicate with MTA, which by default is installed on many GNU/Linux distributions, but not Ubuntu. An easy and frequently helpful replacement is postfix, a lightweight mail client.

`sudo apt install postfix`

If you're unsure of which settings to use, select 'no configuration' and then run `sudo service postfix reload`

### Python
Helper scripts were written for python 3.
You can either install the required python libraries directly to your server with:

`pip install -r requirements.txt`

Or you can install these within a vitrual environment (preferred) and be sure to activate that before running these scripts. If you do this, there may be an additional configuration step to make scripts run as expected, particularly if you won't be running them by hand (such as with a cron job)


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
    * This is set to 90 by default
 * (Optional) The location of the python binary you wish to run
    * If you have a virtual environment, point this at it, such as: /path/to/venv/bin/python
 * (Optional) The absolute location of the parse script. The default value will work fine for running by hand, but not for things like cron jobs.

### Run:
Run with `./snapshot.sh`
