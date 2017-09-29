
require 'json'
require_relative "configuration_model.rb"
require_relative "extension_methods.rb"

class ConfigurationRepository

	def initialize(defaultFile, overrideFile)
		@defaultConfigFile = defaultFile
		@overrideConfigFile = overrideFile
	end # end def initialize (constructor)

	private def loadConfigFiles()

		_configs = {}
	
		if File.exists?(File.expand_path @defaultConfigFile)
			_configs[Configuration::DEFAULTS_KEY] = JSON.parse(File.read(File.expand_path @defaultConfigFile))
		else
			raise "Default Configuration file not found."
		end
		
		if File.exists?(File.expand_path @overrideConfigFile)
			_configs[Configuration::OVERRIDES_KEY] = JSON.parse(File.read(File.expand_path @overrideConfigFile))
		else
			raise "Override Configuration file not found."
		end
	
		return _configs
	
	end # end private def loadConfigFiles

	public def buildConfiguration()
	
		_configs = loadConfigFiles()
		_merged = {}

		# Merge Vagrant Configurations
		_merged[Configuration::VAGRANT_KEY] = _configs[Configuration::DEFAULTS_KEY][Configuration::VAGRANT_KEY]

		if !_configs[Configuration::OVERRIDES_KEY][Configuration::VAGRANT_KEY].nil?
			_merged[Configuration::VAGRANT_KEY] = _merged[Configuration::VAGRANT_KEY]
				.mergeConfigurations(_configs[Configuration::OVERRIDES_KEY][Configuration::VAGRANT_KEY])
		end # end Merging of Vagrant Configurations
	
		# Merge Server Configurations
		_merged[Configuration::SERVERS_KEY] = []

		_configs[Configuration::OVERRIDES_KEY][Configuration::SERVERS_KEY].each do |server|
			_merged[Configuration::SERVERS_KEY].push(
				_configs[Configuration::DEFAULTS_KEY][Configuration::SERVERS_KEY]
				.mergeConfigurations(server))
		end # end Merging of Server Configurations
	
		return Configuration.new(_configs, _merged)
	
	end # end public def buildConfiguration

end # end class ConfigurationRepository
