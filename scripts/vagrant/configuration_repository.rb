
require 'json'
# require 'yaml'

class Hash
	def mergeConfigurations(override_hash)
		self.merge(override_hash) do |key, global_value, override_value|
			if global_value.is_a?(Hash)
				global_value.mergeConfigurations(override_value)
			elsif global_value.is_a?(Array)
				global_value.push(*override_value)
			else
				override_value.nil? ? global_value : override_value
			end
		end
	end
end

class ConfigurationRepository

	def initialize(defaultFile, overrideFile)
		@defaultConfigFile = defaultFile
		@overrideConfigFile = overrideFile
	end # end def initialize (constructor)

	private def loadConfigFiles()

		_configs = {}
	
		if File.exists?(File.expand_path @defaultConfigFile)
			_configs["defaults"] = JSON.parse(File.read(File.expand_path @defaultConfigFile))
		else
			raise "Default Configuration file not found."
		end
		
		if File.exists?(File.expand_path @overrideConfigFile)
			_configs["overrides"] = JSON.parse(File.read(File.expand_path @overrideConfigFile))
		else
			raise "Override Configuration file not found."
		end
	
		return _configs
	
	end # end private def loadConfigFiles

	public def buildConfiguration()
	
		_configs = loadConfigFiles()
		_merged = {}

		# Merge Vagrant Configurations
		_merged["vagrant"] = _configs["defaults"]["vagrant"]
		if !_configs["overrides"]["vagrant"].nil?
			_merged["vagrant"] = _merged["vagrant"].mergeConfigurations(_configs["overrides"]["vagrant"])
		end # end Merging of Vagrant Configurations
	
		# Merge Server Configurations
		_merged["servers"] = []
		_configs["overrides"]["servers"].each do |server|
			_merged["servers"].push(_configs["defaults"]["servers"].mergeConfigurations(server))
		end # end Merging of Server Configurations
	
		return Configuration.new(_configs, _merged)
	
	end # end public def buildConfiguration

end # end class ConfigurationRepository

class Configuration

	def initialize(configs, merged)
		@defaultConfigs = configs["defaults"]
		@overrideConfigs = configs["overrides"]
		@mergedConfigs = merged
	end # end def initialize (constructor)

	def ForVagrant
		@mergedConfigs['vagrant']
	end # end def ForVagrant
		
	def ForServers
		@mergedConfigs['servers']
	end # end def ForServers

	# Generate Reader Access for Configs
	attr_reader :defaultConfigs, :overrideConfigs, :mergedConfigs
	
end # end class Configuration