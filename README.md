# nrpe-nagios-plesk-backup-monitor
NRPE check Plesk backup status

Summary:
This is a plugin (backup_plesk_checker) that monitors backup status in Plesk panel - Success/Warning/Error/Date checker.


Full Description:
This is a basic plugin (backup_plesk_checker) that monitors backup activities in Plesk panel.
This plugin have 4 main options:
1) Success status - backup ok
2) Warning status - backup have warnings
3) Error status - backup have errors
4) Backup Completed unsuccessfully - date of the server not equal to backup date
5) Not all domains are backuped - How many domains have been backuped if the number is not equal it will give warning
and will be more :) 


=>>
NEW V.1.0 script can only check PLESK backup status + dumpstatus !!
=

Compatibility with plesk panel versions:
1) 17.8 - NO
2) 17.5 - NO
3) 17.0 - OK
4) 12.5 - OK
5) 12.0 - OK
6) 11.0 - OK

Installation instructions:

Put some txt file or other file inside one of the domains and change perrmissions to it : 
/var/www/vhosts/example.com/httpdocs/file.txt
chmod 600 /var/www/vhosts/example.com/httpdocs/file.txt
chown root:root /var/www/vhosts/example.com/httpdocs/file.txtchown root:root /var/www/vhosts/example.com/httpdocs/file.txt
*This is needed to do - without it this script will not work - in 0.3 i will fix the warnings to that file .

Edit file /etc/sudoers and add the following;

nrpe ALL=(root) NOPASSWD: /usr/lib64/nagios/plugins/backup_plesk_checker.sh
nagios ALL=(root) NOPASSWD: /usr/lib64/nagios/plugins/backup_plesk_checker.sh
Edit file /etc/nagios/nrpe.cfg and add the following;

command[check_backup]=/usr/bin/sudo /usr/lib64/nagios/plugins/backup_plesk_checker.sh
Copy backup_plesk_checker.sh to /usr/lib64/nagios/plugins/ and give this script 777 or just execute :)

And the Final step is to define service/define command to specific servers in Nagios server.

Make sure that in /usr/local/psa/admin/share/pmmcli/pmmcli-rc you have 
DAYS_TO_KEEP_SESSIONS 30
This parameter working ONLY for backups that have errors or warnings.

In next version ( 0.3 ) will be with workaround for that plesk "feature"..

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
# Change log

==>
NEW V.1.0 script can only check PLESK backup status + dumpstatus !!
=

05.12.18 - 1.0
1)EDIT: script redesign

07.02.2018 - 0.3

1)ADDED : Added one more log location to check if all is ok. 

23.08.2017 - 0.2
1) EDIT: Removed bash debug (#set -x)
2) ADDED: NEW check!!! How many domains have been backuped - if the number is not equeal it will give warning
3) EDIT: Comments in the code + some cleaning...

20.08.2017 - 0.1a
1) First release 
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
nrpe-nagios-plesk-backup-monitor 23.08.2017 v0.2 
Written by Sergey Babkevych SecurityInet https://www.securityinet.com
Email: kamtec1 @ gmail
Plugin main page: https://www.securityinet.com/nrpe-nagios-plesk-backup-monitor/
nrpe-nagios-plesk-backup-monitor is licensed under the GNU General Public License v3.0
