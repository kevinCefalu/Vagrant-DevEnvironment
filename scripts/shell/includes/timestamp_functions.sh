
#!/bin/bash
# Timestamp Helper Functions script

# Date/Time Helper Functions
get_date() 
{ 
	date +"%Y$1%m$1%d" 
}

get_time() 
{ 
	date +"%H$1%M$1%S" 
}

get_timestamp() 
{ 
	echo "$(get_date $1)$2$(get_time $3)"
}