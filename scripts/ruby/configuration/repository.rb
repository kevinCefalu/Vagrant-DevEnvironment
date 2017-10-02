
####################################################################################################
# Title::		Configuration Repository: VagrantFile Configuration Repository
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	A repository for returning information from a properly 
#				defined Configuration model for consumption in a VagrantFile
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of ConfigurationRepository & documentation
####################################################################################################

require 'json'
require_relative "model.rb"
require_relative "../helpers/collections.rb"
require_relative "../helpers/logger.rb"

class ConfigurationRepository

	# Description::	Initialize/Construct a new Configuration Repository object
	# Parameters::	
	# 	(Configuration) model: A properly defined Configuration model
	def initialize(model)
		@model = model
	end # end def initialize (constructor)

	# Description::	Getter for the configuration object
	# Return Type::	Ruby.Hash
	def ConfigurationModel 
		@model 
	end # end public def ConfigurationModel

	# Description::	Getter for the configuration validity flag
	# Return Type::	Ruby.Hash
	def ConfigsAreValid 
		@model.ConfigsAreValid 
	end # end public def ConfigsAreValid
	
	# Description::	Getter for the defaults configurations hash
	# Return Type::	Ruby.Hash
	def DefaultConfigs 
		@model.DefaultConfigs 
	end # end public def DefaultConfigs
	
	# Description::	Getter for the overrides configurations hash
	# Return Type::	Ruby.Hash
	def OverrideConfigs 
		@model.OverrideConfigs 
	end # end public def OverrideConfigs
	
	# Description::	Getter for the merged configurations hash
	# Return Type::	Ruby.Hash
	def MergedConfigs 
		@model.MergedConfigs 
	end # end public def MergedConfigs

	# Description::	Getter for the Vagrant configuration hash 
	# Return Type::	Ruby.Hash
	def ForVagrant 
		@model.ForVagrant 
	end # end public def ForVagrant
	
	# Description::	Getter for the server definition array
	# Return Type::	Ruby.Array
	def ForServers 
		@model.ForServers 
	end # end public def ForServers

	# Description::	Public method used to query the merged configuration hash by providing a 
	#				string representation of the path needed to traverse to the target property
	# Parameters::	
	#	(Hash) collection: 	a collection of configurations to be traversed using the jsonPath
	#	(String) jsonPath: 	a string representation of the path needed to traverse to the target property
	#						I.e., "Vagrant/host_locale" for values in a hash, or "Servers/0/hostname".
	#						Note the '0', which is used to indicate the indice of the array "Servers".
	# Return Type::	depends on the value found at the path (but likely serialized to Ruby.String)
	def GetValueFrom(collection, jsonPath)
		return Collection::GetValueFromPath(collection, jsonPath)
	end # end public def GetValue

	# Description::	Public method used to query the merged configuration hash by providing a 
	#				string representation of the path needed to traverse to the target property
	# Parameters::	
	#	(String) jsonPath: 	a string representation of the path needed to traverse to the target property
	#						I.e., "Vagrant/host_locale" for values in a hash, or "Servers/0/hostname".
	#						Note the '0', which is used to indicate the indice of the array "Servers".
	# Return Type::	depends on the value found at the path (but likely serialized to Ruby.String)
	def GetValue(jsonPath)
		return Collection::GetValueFromPath(@model.MergedConfigs, jsonPath)
	end # end public def GetValue

	# Description::	Public method used to return the value of the current provision script argument, 
	# 				or query the merged configuration collection for the argument value
	# Parameters::	
	#	(Hash) argInstance:	the definition of a script instance argument
	# Return Type::	depends on the value found (but likely serialized to Ruby.String)
	def GetScriptArgument(argInstance)
		
		# Check whether the argument instance specifies that the value needs to be queried 
		# from the merged configuration collection, or whether its defined in place
		if argInstance["_type"] === "json_path"
			# If so, the argument value needs to be traversed to, 
			# through the merged configuration collection
			return GetValue(argInstance["path"]) 
		else 
			# Else, the value is stored in the argument instance
			return argInstance["value"]
		end # end if

	end # end def GetScriptArgument

	# Description::	Used to log all configuration versions (i.e., deserialized default 
	# 				and override configs, as well as the merged result of those files)
	def LogConfigurations()

		# Build a composite hash, 
		configHash = {}
		configHash[Configuration::DEFAULTS_KEY] = @model.DefaultConfigs
		configHash[Configuration::OVERRIDES_KEY] = @model.OverrideConfigs
		configHash[Configuration::MERGED_KEY] = @model.MergedConfigs

		# And log it to the console in JSONP format
		Logger.LogToConsole(configHash, true);

	end # end public def logConfiguration

end # end class ConfigurationRepository
