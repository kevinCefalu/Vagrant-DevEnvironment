
#!/bin/bash

####################################################################################################
# Title::		Linux Init Script: Shell Apt-Get script 
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	A script to set timezone, as well as update, upgrade and install linux packages
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of linux init script & documentation
####################################################################################################

. /scripts/shell/includes/logger_functions.sh

log_file="/logs/init/setup_vm.log" 

# Begin setting the virtual machine's time zone to the configured time zone
log_message "Setting VM TimeZone: $1" $log_file 
sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/$1 /etc/localtime | log_output $log_file 
# End setting the virtual machine's time zone to the configured time zone

# do-release-upgrade -f DistUpgradeViewNonInteractive

# Begin making sure that the linux virtual machines packages are updated & upgraded
log_message "Updating packages" $log_file 
sudo apt-get update -y | log_output $log_file  
sudo apt-get upgrade -y | log_output $log_file 
# End making sure that the linux virtual machines packages are updated & upgraded

# Begin installing the defined packages listed in the file passed in $2
log_message "Installing packages" $log_file 
sudo apt-get install -y $(cat $2) | log_output $log_file 
# End installing the defined packages listed in the file passed in $2
