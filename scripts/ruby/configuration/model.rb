
####################################################################################################
# Title::		Configuration: VagrantFile Configuration model
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	A collection of all deserialized configuration hashes, 
# 				and hash keys to standardize navigation of those collections
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of Configuration model & documentation
####################################################################################################

class Configuration
	
	# Description::	Hash Key Constant Definitions
	DEFAULTS_KEY = "defaults".freeze 	# 'Defaults' configuration collection key
	OVERRIDES_KEY = "overrides".freeze 	# 'Overrides' configuration collection key
	VAGRANT_KEY = "vagrant".freeze 		# 'Vagrant' configuration collection key
	SERVERS_KEY = "servers".freeze 		# 'Servers' configuration collection key
	MERGED_KEY = "merged".freeze 		# 'Merged' configuration collection key
	# end public constant variable definitions

	# Description::	Initialize/Construct a new Configuration object
	# Parameters::	
	# 	(Boolean) areConfigsValid: a flag indicating whether the configuration files were found to be valid
	#	(Hash) deserializedConfigs: a collection containing the deserialized configuration files
	#	(Hash) mergedConfigs: a collection containing the result of merging the deserialized hashes
	def initialize(areConfigsValid, deserializedConfigs, mergedConfigs)

		@ConfigsAreValid = areConfigsValid
		@DefaultConfigs = deserializedConfigs[DEFAULTS_KEY].clone
		@OverrideConfigs = deserializedConfigs[OVERRIDES_KEY].clone
		@MergedConfigs = mergedConfigs.clone
		
	end # end def initialize (constructor)

	# Description::	Generate Getters for Configuration Collections
	attr_reader :ConfigsAreValid, :DefaultConfigs, :OverrideConfigs, :MergedConfigs
	# end attr_reader

	# Description::	Getter for Merged Configuration for Vagrant Settings
	# Return Type::	Ruby.Hash
	public def ForVagrant 
		@MergedConfigs[VAGRANT_KEY] 
	end # end public def ForVagrant
	
	# Description::	Getter for Merged Configuration for Server Settings 
	# Return Type::	Ruby.Array
	public def ForServers
		@MergedConfigs[SERVERS_KEY] 
	end # end public def ForServers

end # end class Configuration
