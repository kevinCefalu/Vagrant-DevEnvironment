
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
require_relative "../helpers/configuration.rb"
require_relative "../helpers/logger.rb"

class ConfigurationRepository

	# Description::	Local copies of Configuration hash keys, used 
	#				mostly just to make lines a little more terse
	private _defaultsKey = Configuration::DEFAULTSKey
	private _overridesKey = Configuration::OVERRIDESKey
	private _vagrantKey = Configuration::VAGRANTKey
	private _serversKey = Configuration::SERVERSKey

	# Description::	Initialize/Construct a new Configuration Repository object
	# Parameters::	
	# 	(Configuration) model: A properly defined Configuration model
	def initialize(model)

		@model = model
	
	end

	# Description::	Getter for the configuration object
	# Return Type::	Ruby.Hash
	public def ConfigurationModel @model end

	# Description::	Getter for the configuration validity flag
	# Return Type::	Ruby.Hash
	public def ConfigsAreValid @model.ConfigsAreValid end 
	
	# Description::	Getter for the defaults configurations hash
	# Return Type::	Ruby.Hash
	public def DefaultConfigs @model.DefaultConfigs end 
	
	# Description::	Getter for the overrides configurations hash
	# Return Type::	Ruby.Hash
	public def OverrideConfigs @model.OverrideConfigs end 
	
	# Description::	Getter for the merged configurations hash
	# Return Type::	Ruby.Hash
	public def MergedConfigs @model.MergedConfigs end 

	# Description::	Getter for the Vagrant configuration hash 
	# Return Type::	Ruby.Hash
	public def ForVagrant @model.ForVagrant end 
	
	# Description::	Getter for the server definition array
	# Return Type::	Ruby.Array
	public def ForServers @model.ForServers end

	# Description::	Public method used to query the merged configuration hash by providing a 
	#				string representation of the path needed to traverse to the target property
	# Parameters::	
	#	(String) jsonPath: 	a string representation of the path needed to traverse to the target property
	#						I.e., "Vagrant/host_locale" for values in a hash, or "Servers/0/hostname".
	#						Note the '0', which is used to indicate the indice of the array "Servers".
	# Return Type::	depends on the value found at the path (but likely serialized to Ruby.String)
	public def GetValue(jsonPath)
	{
		return ConfigurationExtensions::GetValueFromPath(@model.MergedConfigs, jsonPath)
	}

	# Description::	Used to log all configuration versions (i.e., deserialized default 
	# 				and override configs, as well as the merged result of those files)
	public def LogConfigurations()

		Logger.LogToConsole({ 
			Defaults: @model.DefaultConfigs
			Overrides: @model.OverrideConfigs
			Merged: @model.MergedConfigs
		}, true);

	end # end public def logConfiguration

end # end class ConfigurationRepository
