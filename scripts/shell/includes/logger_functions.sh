#!/bin/bash
# Logger Helper Functions script

. timestamp_functions.sh

# Logger Helper Functions
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

log_output() 
{
	while read data 
	do 
		log_message "$data" "$1" 
	done 
}
