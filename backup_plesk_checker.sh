#!/bin/bash

#nrpe-nagios-plesk-backup-monitor v 0.1a
#Written by Sergey Babkevych (kamtec1) SecurityInet 
#SecurityInet Web site for updates regarding new release
#https://www.securityinet.com
#Github link for updates:
#https://github.com/kamtec1/nrpe-nagios-plesk-backup-monitor
#kamtec1/nrpe-nagios-plesk-backup-monitor is licensed under the GNU General Public License v3.0
#If you hgave questions you may send me a massage : kamtec1@gmail.com or sergey@securityinet.com



set -x
LC_ALL=C
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2

current_date=`date +%Y-%m-%d`
#echo $current_date

#get date format from file
backup_date_check=$(ls --time-style=+%s --sort=time /usr/local/psa/PMM/sessions | grep -v "^total " | head -n 1 | cut -d "-" -f1,2,3)
#echo $backup_date_check

#printf $backup_date_check >> /var/log/check_backup.log

##########################################
#check if time of the folder is the time of the server - every day backup
##########################################

if [ "$current_date" != "$backup_date_check" ]
then
echo "Backup Completed unsuccessfully - Backup folder $backup_date_check"
exit $STATE_CRITICAL
fi

########################################
########################################

#main location of backup logs
dirlocation="/usr/local/psa/PMM/sessions"


LASTFILE=$(ls --time-style=+%s --sort=time "$dirlocation" | grep -v "^total " | head -n 1)

#get date format from file
backup_date=$(ls --time-style=+%s --sort=time "$dirlocation" | grep -v "^total " | head -n 1 | cut -d "-" -f1,2,3)

ffile01=$(ls "/usr/local/psa/PMM/sessions/$LASTFILE" | grep "migration.result")

#recursive grep file migration.result to find patterns
serverstatus=$(grep -r 'execution-result status="warnings"\|execution-result status="error"\|execution-result status="success"' $dirlocation/$LASTFILE/$ffile01 | awk '{print $2}' | cut -d "=" -f 2 | tr -d '"')

#############################################################
#############################################################

#use of if

if      [ $serverstatus == 'success' ]
then
        echo "server is backuped OK -Server date: $current_date -Backup date: $backup_date"
#        echo $STATE_OK
        exit $STATE_OK

elif    [ $serverstatus == 'warnings' ]
then
        echo "server is backuped with $serverstatus -warn-Backup date: $backup_date"
#        echo $STATE_WARNING
        exit $STATE_WARNING
else
        echo "server is backuped with $serverstatus -crit-Backup date: $backup_date"
#        echo $STATE_CRITICAL
        exit $STATE_CRITICAL
fi