
#!/bin/bash

####################################################################################################
# Title::		DateTime Helpers: Shell DateTime Helper Functions script
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	A collection of bash shell functions to help get and format Timestamps
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of DateTime functions & documentation
####################################################################################################

# Description::	Used to format the current date
# Parameters::	
#	(String) $1:	The delimiter to use between the month, date, and year (I.e., '-' would produce "2017-09-25")
# Return type::	string (I.e., "2017-09-25")
get_date() 
{ 
	date +"%Y$1%m$1%d" 
}

# Description::	Used to format the current time
# Parameters::	
#	(String) $1:	The delimiter to use between the hour, minute, and second (I.e., ':' would produce "11:59:42")
# Return type::	string (I.e., "11:59:42")
get_time() 
{ 
	date +"%H$1%M$1%S" 
}

# Description::	Used to format the current date and time
# Parameters::	
#	(String) $1:	The delimiter to use between the month, date, and year (I.e., '-' would produce "2017-09-25")
#	(String) $2:	The delimiter to use between the date and time strings (I.e., '@' would produce "2017-09-25@11:59:42")
#	(String) $3:	The delimiter to use between the hour, minute, and second (I.e., ':' would produce "11:59:42")
# Return type::	string (I.e., "2017-09-25@11:59:42")
get_timestamp() 
{ 
	echo "$(get_date $1)$2$(get_time $3)"
}
