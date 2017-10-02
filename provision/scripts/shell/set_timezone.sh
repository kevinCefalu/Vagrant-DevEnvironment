
#!/bin/bash
# Bootstrapper to set Time Zone

echo " ===> Setting VM TimeZone: $1"
sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/$1 /etc/localtime
