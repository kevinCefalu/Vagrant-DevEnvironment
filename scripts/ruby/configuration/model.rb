
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
	DEFAULTS_KEY = 'defaults' 		# 'Defaults' configuration collection key
	OVERRIDES_KEY = 'overrides' 	# 'Overrides' configuration collection key
	VAGRANT_KEY = 'vagrant' 		# 'Vagrant' configuration collection key
	SERVERS_KEY = 'servers' 		# 'Servers' configuration collection key

	# Description::	Initialize/Construct a new Configuration object
	# Parameters::	
	# 	(Boolean) areConfigsValid: a flag indicating whether the configuration files were found to be valid
	#	(Hash) deserializedConfigs: a collection containing the deserialized configuration files
	#	(Hash) mergedConfigs: a collection containing the result of merging the deserialized hashes
	def initialize(areConfigsValid, deserializedConfigs, mergedConfigs)

		@ConfigsAreValid = areConfigsValid
		@DefaultConfigs = deserializedConfigs[DEFAULTS_KEY]
		@OverrideConfigs = deserializedConfigs[OVERRIDES_KEY]
		@MergedConfigs = mergedConfigs
		
	end # end def initialize (constructor)

	# Description::	Generate Getters for Configuration Collections
	attr_reader :ConfigsAreValid, :DefaultConfigs, :OverrideConfigs, :MergedConfigs

	# Description::	Getter for Merged Configuration for Vagrant Settings
	# Return Type::	Ruby.Hash
	public def ForVagrant @MergedConfigs[VAGRANT_KEY] end 
		
	# Description::	Getter for Merged Configuration for Server Settings 
	# Return Type::	Ruby.Array
	public def ForServers @MergedConfigs[SERVERS_KEY] end

end # end class Configuration
