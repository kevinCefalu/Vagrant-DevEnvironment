
#!/bin/bash

####################################################################################################
# Title::		Logger Helpers: Shell Logger Helper Functions script
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	A collection of bash shell functions to help log messages to console
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of Logger functions & documentation
####################################################################################################

. timestamp_functions.sh

# Description::	Used to print a message to console and a log file, if a filepath has been provided
# Parameters::	
#	(String) $1:	The message intended to be logged
#	(String) $2:	An optional filepath to log the message to, in addition to the console
log_message() 
{ 
	message="$(get_timestamp '' '@' ':') ==> $1\n"

	if [ -z "$2" ] 
	then # Print to console, only
		printf "$message"
	else # Print to console, and log to file referenced in $2
		printf "$message"  2>&1 | tee -a "$2"
	fi
}

# Description::	Used to log the output of a command to console, as well as a log file, if a filepath has been provided
# Parameters::	
#	(String) $1:	An optional filepath to log the output to, in addition to the console
log_output() 
{
	while read data 
	do 
		log_message "$data" "$1" 
	done 
}
