
#!/bin/bash
# Archive existing log files in log folder sync

. /scripts/shell/includes/logger_functions.sh

log_file="/logs/init/setup_vm.log" 

# Set the virtual machine's time zone to the configured time zone
log_message "Setting VM TimeZone: $1" $log_file 
sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/$1 /etc/localtime | log_output $log_file 

# do-release-upgrade -f DistUpgradeViewNonInteractive

# Make sure that the linux virtual machines packages are updated & upgraded
log_message "Updating packages" $log_file 
sudo apt-get update -y | log_output $log_file  
sudo apt-get upgrade -y | log_output $log_file 

# Install the defined packages listed in the file passed in $2
log_message "Installing packages" $log_file 
sudo apt-get install -y $(cat $2) | log_output $log_file 
