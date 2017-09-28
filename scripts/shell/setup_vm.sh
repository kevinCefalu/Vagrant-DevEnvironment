
#!/bin/bash
# Archive existing log files in log folder sync

. /scripts/shell/includes/timestamp_functions.sh
. /scripts/shell/includes/logger_functions.sh

log_file="/logs/init/setup_vm.log" 

log_message "Setting VM TimeZone: $1" $log_file 
sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/$1 /etc/localtime | log_output $log_file 

log_message "Updating packages" $log_file 
sudo apt-get update | log_output $log_file  
sudo apt-get upgrade | log_output $log_file 

log_message "Installing packages" $log_file 
sudo apt-get install -y $(cat $2) | log_output $log_file 
