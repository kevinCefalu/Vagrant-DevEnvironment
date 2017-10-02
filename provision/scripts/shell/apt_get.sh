
#!/bin/bash
# Bootstrapper for apt-get's

echo " ==> Updating packages"
sudo apt-get update #> /dev/null
sudo apt-get upgrade #> /dev/null

echo " ==> Installing packages"
sudo apt-get install -y git nodejs nginx #> /dev/null
