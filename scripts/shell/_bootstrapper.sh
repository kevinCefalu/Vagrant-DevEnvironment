
#!/bin/bash

####################################################################################################
# Title::		Provisioner Bootstrap: Shell Provisioner Bootstrapping script
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	A provisioner bootstrap script to run all provisioning bash shell scripts
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of Bootstrapper & documentation
####################################################################################################

cat << "EOA"
=============================================================================
	    ____       _ ____  _ __  ____                                  
	   / __ \_____(_) __ )(_) /_/ __ \___ _   __                       
	  / /_/ / ___/ / __  / / __/ / / / _ \ | / /                       
	 / ____(__  ) / /_/ / / /_/ /_/ /  __/ |/ /                        
	/_/ __//___/_/_____/_///_/_____//___/|___/                         
	   / __ )____  ____  / /______/ /__________ _____  ____  ___  _____
	  / __  / __ \/ __ \/ __/ ___/ __/ ___/ __ `/ __ \/ __ \/ _ \/ ___/
	 / /_/ / /_/ / /_/ / /_(__  ) /_/ /  / /_/ / /_/ / /_/ /  __/ /    
	/_____/\____/\____/\__/____/\__/_/   \__,_/ .___/ .___/\___/_/     
	                                         /_/   /_/                 
=============================================================================
EOA

# Ensure that log directories have been created properly
mkdir -p /logs/init/_Archive > /dev/null 
mkdir -p /logs/nginx/_Archive > /dev/null 

# Archive existing log files in log folder sync
. /scripts/shell/archive_logs.sh

# Bootstrapper to set-up and configure the VM
. /scripts/shell/setup_vm.sh $1 $2
