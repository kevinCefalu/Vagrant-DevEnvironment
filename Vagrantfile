
# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative "scripts/ruby/configuration/model.rb"
require_relative "scripts/ruby/configuration/factory.rb"
require_relative "scripts/ruby/configuration/repository.rb"
require_relative "scripts/ruby/helpers/collections.rb"
require_relative "scripts/ruby/helpers/logger.rb"

defaultsFilePath = "./configs/vagrant/config.defaults.json"
overridesFilePath = "./configs/vagrant/config.json"

# Build Merged Configuration Repository
configRepo = ConfigurationFactory::BuildConfigRepo(defaultsFilePath, overridesFilePath)
# Log Configuration collection to the console
# configRepo.LogConfigurations() 

Vagrant.configure(configRepo.ForVagrant['version']) do |v_config|

	v_config.ssh.insert_key = configRepo.GetValue("vagrant/ssh/enable_custom")

	# Configuration Loop for each server defined in Merged Configuration
	configRepo.ForServers.each do |svr_inst|

		if svr_inst["enabled"]

			hostName = svr_inst["hostname"]

			# Begin configuring the virtual machine Definition
			v_config.vm.define hostName do |svr_def|

				# Begin configuring the virtual machine's box image definition
				svr_def.vm.hostname = hostName
				svr_def.vm.box = configRepo.GetValueFrom(svr_inst, "vm/image/name")
				svr_def.vm.box_check_update = configRepo.GetValueFrom(svr_inst, "vm/image/check_for_update")
				# End configuring the virtual machine's box image definition

				# Begin configuring the virtual machine's network definition
				svr_def.vm.network configRepo.GetValueFrom(svr_inst, "hardware/nic/_type"), 
					ip: configRepo.GetValueFrom(svr_inst, "hardware/nic/ip")

				# Begin configuring the virtual machine's port forward definitions
				configRepo.GetValueFrom(svr_inst, "hardware/nic/port_fwds").each do |pf_inst|
					
					svr_def.vm.network :forwarded_port, 
						id: configRepo.GetValueFrom(pf_inst, "id"), 
						auto_correct: configRepo.GetValueFrom(pf_inst, "auto_correct"), 
						guest: configRepo.GetValueFrom(pf_inst, "ports/guest"), 
						host: configRepo.GetValueFrom(pf_inst, "ports/host") 

				end # End forwarded_ports.each
				# End configuring the virtual machine's port forward definitions
				# End configuring the virtual machine's network definition

				# Begin configuring the virtual machine's virtualBox provider
				svr_def.vm.provider :virtualbox do |vb_def|

					vb_def.name = hostName
					vb_def.cpus = configRepo.GetValueFrom(svr_inst, "hardware/cpu_count")
					vb_def.memory = configRepo.GetValueFrom(svr_inst, "hardware/ram_total")
					# Important to fix an issue with ubuntu 16.x's SSH connection
					vb_def.customize ["modifyvm", :id, "--cableconnected1", "on"]

				end # End vb_def
				# End configuring the virtual machine's virtualBox provider

				# Begin configuring the virtual machine Folder Syncs
				configRepo.GetValueFrom(svr_inst, "fs_syncs").each do |fs_inst|

					svr_def.vm.synced_folder configRepo.GetValueFrom(fs_inst, "paths/host"), configRepo.GetValueFrom(fs_inst, "paths/guest"), 
						disabled: !configRepo.GetValueFrom(fs_inst, "enabled") 

				end # fs_inst.each
				# End configuring the virtual machine's folder syncs

				# Begin configuring the virtual machine's provisioner scripts
				configRepo.GetValueFrom(svr_inst, "scripts").each do |scr_inst|
					svr_def.vm.provision configRepo.GetValueFrom(scr_inst, "_type") do |script_definition|

						script_definition.name = configRepo.GetValueFrom(scr_inst, "name")
						script_definition.path = configRepo.GetValueFrom(scr_inst, "path")
						script_definition.args = []

						# Build the script definition's array of arguments
						configRepo.GetValueFrom(scr_inst, "args").each do |arg_inst|
							script_definition.args.push(configRepo.GetScriptArgument(arg_inst))
						end # End arg_inst.each

					end # End script_definition
				end # End scr_inst.each
				
				# Begin configuring the virtual machine for docker & docker-compose 
				if configRepo.GetValueFrom(svr_inst, "docker/enabled")
					
					svr_def.vm.provision :docker
					svr_def.vm.provision :docker_compose,
						run: configRepo.GetValueFrom(svr_inst, "docker/run"), 
						yml: configRepo.GetValueFrom(svr_inst, "docker/compose_file")
					
				end # End if docker is enabled
				# End configuring the virtual machine for docker & docker-compose
				# End configuring the virtual machine provisioner scripts

			end # End svr_def
			# End configuring the virtual machine definition
		
		end # End if srv_inst is enabled

	end # End svr_inst.each
	# End the configuration loop for each server defined in the merged configuration

end # End v_config
