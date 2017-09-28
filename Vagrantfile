
# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative "scripts/ruby/log_sync.rb"
require_relative "scripts/ruby/configuration_repository.rb"

defaultConfigFile = "./configs/vagrant/config.defaults.json"
configOverridesFile = "./configs/vagrant/config.json"

configRepo = ConfigurationRepository.new(defaultConfigFile, configOverridesFile)
configuration = configRepo.buildConfiguration()

# Logging of Configuration collections
# Logger.LogToConsole(configuration.MergedConfigs, true)
# Logger.LogToConsole(configuration.ForVagrant, true)
# Logger.LogToConsole(configuration.ForServers, true)
# Logger.LogToConsole(configuration._defaultConfigs, true)
# Logger.LogToConsole(configuration._overrideConfigs, true)

Vagrant.configure(configuration.ForVagrant['version']) do |config|

	config.ssh.insert_key = configuration.ForVagrant["ssh"]['enable_custom_ssh_key']

	# Configuration Loop for each server defined in Merged Configuration

		configuration.ForServers.each do |server_instance|
			
			# Configure Virtual Machine Definition

				config.vm.define server_instance["hostname"] do |server_definition|

					# Configure Virtual Machine Box image definition
					
						server_definition.vm.hostname = server_instance["hostname"]
						server_definition.vm.box = server_instance['vm']["image"]["name"]
						server_definition.vm.box_check_update = server_instance['vm']["image"]['check_for_update']

					# end Configuration of Virtual Machine Box image definition

					# Configure Virtual Machine Network definition

						server_definition.vm.network server_instance['hardware']['nic']['network_type'], 
							ip: server_instance['hardware']['nic']['ip_address']

						# Configure Virtual Machine Network Port Forward definitions
							
							server_instance['hardware']['nic']['port_fwds'].each do |port_forward_instance|
								server_definition.vm.network :forwarded_port, 
									id: port_forward_instance["id"], 
									auto_correct: port_forward_instance["auto_correct"], 
									guest: port_forward_instance["ports"]["guest"], 
									host: port_forward_instance["ports"]["host"] 
							end # forwarded_ports.each

						# end Configuration of Virtual Machine Network Port Forward definitions

					# end Configuration of Virtual Machine Network definition

					# Configure Virtual Machine VirtualBox Provider

						server_definition.vm.provider :virtualbox do |virtualbox_definition|
						
							virtualbox_definition.name = server_instance["hostname"]
							virtualbox_definition.cpus = server_instance['hardware']["cpu_count"]
							virtualbox_definition.memory = server_instance['hardware']["ram_total"]
							virtualbox_definition.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
						end # end config.vm.provider

					# end Configuration of Virtual Machine VirtualBox Provider

					# Configure Virtual Machine Folder Syncs
					
						server_instance['fs_syncs'].each do |fs_sync_instance|
					
							server_definition.vm.synced_folder fs_sync_instance['paths']['host'], fs_sync_instance['paths']['guest'], 
								disabled: !fs_sync_instance['enabled'] 

						end # server_instance['fs_sync'].each
					
					# end Configuration of Virtual Machine Folder Syncs

					# Configure Virtual Machine Provisioner Scripts

						server_instance["scripts"].each do |script_instance|
					
							server_definition.vm.provision script_instance["_type"] do |script_definition|
							
								script_definition.name = script_instance["name"]
								script_definition.path = script_instance["path"]

								if script_instance["args"] != nil && script_instance["args"].length > 0
									script_definition.args = []
								end

								script_instance["args"].each do |argument_instance|
							
									if argument_instance["_type"] === "json_path"
										script_definition.args.push(ConfigurationExtensions::getValueFromPath(
											configuration.MergedConfigs, argument_instance["path"]))
									else
										script_definition.args.push(argument_instance["value"])
									end # end if argument_instance["_type"]

								end # end script_instance["args"].each
								
							end # end server_definition.vm.provision :shell

						end # end server_definition["scripts"].each
					
					# end Configuration of Virtual Machine Provisioner Scripts

				end # end config.vm.define

			# end Configuration of Virtual Machine Definition

		end # end configuration.ForServers.each

	# end Configuration Loop for each server defined in Merged Configuration

end # end Vagrant.configure
