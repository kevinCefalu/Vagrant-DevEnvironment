
#!/bin/bash
# Archive existing log files in log folder sync

. /scripts/shell/includes/timestamp_functions.sh
. /scripts/shell/includes/logger_functions.sh

log_file="/logs/init/setup_nginx.log" 

log_message "Starting & Configuring NGinx Web Server" $log_file
sudo service nginx start | log_output $log_file 

log_message "Copying /configs/nginx/nginx.conf => /etc/nginx/sites-available/site.conf" $log_file 
sudo cp /configs/nginx/nginx.conf /etc/nginx/sites-available/site.conf -f | log_output $log_file 
# sudo cp /configs/nginx/proxy.conf /etc/nginx/sites-available/proxy.conf -f | log_output $log_file 
# sudo cp /configs/nginx/mime.types /etc/nginx/sites-available/mime.types -f | log_output $log_file 

log_message "Changing permissions of /etc/nginx/sites-available/site.conf to 644" $log_file
sudo chmod 644 /etc/nginx/sites-available/site.conf | log_output $log_file 
# sudo chmod 644 /etc/nginx/sites-available/proxy.conf | log_output $log_file 
# sudo chmod 644 /etc/nginx/sites-available/mime.types | log_output $log_file 

log_message "Creating symlink for: /etc/nginx/sites-available/site.conf => /etc/nginx/sites-enabled/site.con" $log_file
sudo ln -f -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/site.conf | log_output $log_file 
# sudo ln -f -s /etc/nginx/sites-available/proxy.conf /etc/nginx/sites-enabled/proxy.conf | log_output $log_file 
# sudo ln -f -s /etc/nginx/sites-available/mime.types /etc/nginx/sites-enabled/mime.types | log_output $log_file 

log_message "Restarting NGinx Service" $log_file
sudo service nginx restart | log_output $log_file 

log_message "Cleaning existing files from /var/www" $log_file
sudo rm -Rf /var/www | log_output $log_file 

log_message "Creating symlink for: /var/www => /app" $log_file
sudo ln -s /app /var/www | log_output $log_file 

log_message "Creating symlink for: /var/log/nginx => /logs/nginx" $log_file
sudo ln -s -f /var/log/nginx/access.log /logs/nginx/access.log | log_output $log_file 
sudo ln -s -f /var/log/nginx/error.log /logs/nginx/error.log | log_output $log_file 
