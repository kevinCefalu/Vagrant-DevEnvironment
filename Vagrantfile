
# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative "scripts/vagrant/configuration_repository.rb"

defaultConfigFile = "./configs/vagrant/config.defaults.json"
configOverridesFile = "./configs/vagrant/config.json"

configRepo = ConfigurationRepository.new(defaultConfigFile, configOverridesFile)
configuration = configRepo.buildConfiguration()

# puts JSON.pretty_generate(configuration.ForVagrant)
# puts JSON.pretty_generate(configuration.ForServers)
# puts JSON.pretty_generate(configuration.defaultConfigs)
# puts JSON.pretty_generate(configuration.overrideConfigs)
# puts JSON.pretty_generate(configuration.mergedConfigs)


