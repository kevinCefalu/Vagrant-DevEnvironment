
#!/bin/bash
# Archive existing log files in log folder sync

. /scripts/shell/includes/timestamp_functions.sh
. /scripts/shell/includes/logger_functions.sh

original_dir=$PWD

# Begin archiving /logs/init/*.log
cd /logs/init

file_count=$(ls -1 *.log 2>/dev/null | wc -l)
if [[ file_count -gt 0 ]]
then
	# Build today's log archive directory path
	todays_log_archive="_Archive/$(get_date /)"
	log_message "Archiving /logs/init/*.log files to /logs/init/$todays_log_archive"

	# Ensure that the log archive, for today, exists
	mkdir -p "$todays_log_archive"

	# Loop through each .log file in /logs/init
	for log_file in $(ls *.log)
	do
		# Build the log file's new filename
		new_name="$todays_log_archive/$(get_time)-$log_file"
		log_message "Archiving Log: $log_file to $new_name"

		# Move to appropriate archive directory, and prepend timestamp to log file name
		mv $log_file $new_name

	done # end for log_file
fi
# End archiving /logs/init/*.log

# TODO: Should I archive exising /var/logs files somewhere?

cd $original_dir
