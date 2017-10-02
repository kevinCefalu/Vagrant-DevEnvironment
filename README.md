# Vagrant-DevEnvironment
Create a fresh Development Environment using Vagrant, Docker, & the NGinx Base Docker Image

## Table of Contents
1. [Description](#description)
1. [Usage](#usage)
1. [Configuration](#configuration)
1. [Change Log](#change-log)

## Description
This repo is used to create a fresh development environment using Vagrant, Docker, & the NGinx Docker image. This project was attempted because of an issue installing docker, and vagrant, together on one computer. This was causing my work vagrant environment to fail, due to a conflict between virtualbox and Microsoft Hyper-V. 

The environment is pretty slick, and has even been enabled to live-update files in the NGinx container, just by editing the src/ directory listed in the repo. 

## Usage
Use the following instructions to set-up, and run the VagrantFile

1. Install the following dependencies:
    1. [Oracle VM VirtualBox](https://www.virtualbox.org/)
    1. [HashiCorp Vagrant](https://www.vagrantup.com/)
    1. [Vagrant Docker Compose plugin](https://github.com/leighmcculloch/vagrant-docker-compose)
        1. once you have the vagrant installed, run `vagrant plugin install vagrant-docker-compose` in either an elevated powershell prompt
1. Configure the environment how you wish (using instructions in the "Configuration" section), or leave the configuration alone to run it as I've been testing it.
1. Open an elevated powershell prompt, cd to the directory you've cloned the repo to, and run `vagrant up`

## Configuration

## Change Log

- 0.0.1 - 2017-10-02 - Initial Commit
    - Added Files
        - configs/
            - docker/
                - nginx/
                    - mime.types
                    - site.template
                - docker-compose.yml
            - vagrant/
                - schemas/
                    - config-defaults.schema.json
                    - config.schema.json
                    - definitions.schema.json
                - config.defaults.json
                - config.json
            - vm/
                - apt_get_packages_list.txt
        - logs/
        - scripts/
            - ruby/
                - configuration/
                    - factory.rb
                    - model.rb
                    - repository.rb
                    - validator.rb
                - helpers/
                    - collections.rb
                    - logger.rb
                    - string.rb
            - shell/ 
                - includes/
                    - logger_functions.sh
                    - timestamp_functions.sh
                - _bootstrapper.sh
                - archive_logs.sh
                - setup_vm.sh
        - src/
            - index.html
        - .gitattributes
        - .gitignore
        - LICENSE
        - README.model
        - VagrantFile
