
# Configuration Model definition and constant Hash keys
class Configuration
	
	# Hash Key Constant Definitions
	DEFAULTS_KEY = 'defaults' 	# 'Defaults' configuration collection key
	OVERRIDES_KEY = 'overrides' 	# 'Overrides' configuration collection key
	VAGRANT_KEY = 'vagrant' 		# 'Vagrant' configuration collection key
	SERVERS_KEY = 'servers' 		# 'Servers' configuration collection key

	# Initialize/Construct a new Configuration object
	def initialize(configs, merged)
		@_defaultConfigs = configs[DEFAULTS_KEY]
		@_overrideConfigs = configs[OVERRIDES_KEY]
		@MergedConfigs = merged
	end # end def initialize (constructor)

	# Get Merged Configuration for Vagrant Settings (typeOf Hash)
	def ForVagrant
		@MergedConfigs[VAGRANT_KEY]
	end # end def ForVagrant
		
	# Get Merged Configuration for Server Settings (typeOf Array)
	def ForServers
		@MergedConfigs[SERVERS_KEY]
	end # end def ForServers

	# Generate Reader Access for private Configuration Collections
	attr_reader :_defaultConfigs, :_overrideConfigs, :MergedConfigs
	
end # end class Configuration
