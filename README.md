# Vagrant-DevEnvironment
Create a fresh Development Environment using Vagrant, Docker, & the NGinx Base Docker Image

vagrant plugin install vagrant-docker-compose

## Usage
Use the following instructions to set-up, and run the VagrantFile

1. Install the following dependencies
    1. [Oracle VM VirtualBox](https://www.virtualbox.org/)
    1. [HashiCorp Vagrant](https://www.vagrantup.com/)
    1. [Vagrant Docker Compose plugin](https://github.com/leighmcculloch/vagrant-docker-compose)
        1. once you have the vagrant installed, run `vagrant plugin install vagrant-docker-compose` in either an elevated powershell prompt
1. Configure the environment how you wish (using instructions in the "Configuration" section), or leave the configuration alone to run it as I've been testing it.
1. Open an elevated powershell prompt, cd to the directory you've cloned the repo to, and run `vagrant up`
