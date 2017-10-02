
####################################################################################################
# Title::		Configuration Factory: VagrantFile Configuration model factory
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	A factory for loading, deserializing, validating, merging, 
# 				and building a Configuration model for consumption in a VagrantFile
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of ConfigurationFactory & documentation
####################################################################################################

require 'json'
require_relative "model.rb"
require_relative "repository.rb"
require_relative "validator.rb"
require_relative "../helpers/collections.rb"
require_relative "../helpers/logger.rb"

class ConfigurationFactory

	class << self

		# Description::	Static method, called on the factory to load, deserialize, validate, 
		# 				merge, & build a complete view of a configuration, defined in a 
		#				default, as well as an override, JSON file. If you want this factory
		#				to properly validate the JSON configuration files, please ensure that
		# 				the files reference a JSON schema document, in the $schema property
		# Parameters::	
		#	(String) defaultFilePath: a collection containing the deserialized configuration files
		#	(String) overrideFilePath: a collection containing the deserialized configuration files
		# Return Type::	Configuration model
		def BuildConfig(defaultFilePath, overrideFilePath)

			# Load & deserialize the default & override JSON configuration files
			deserializedConfigs = loadConfigurationFiles(defaultFilePath, overrideFilePath)

			# Validate the JSON in the default & override configuration files
			areConfigsValid = validateConfigurationFiles(deserializedConfigs)
			if areConfigsValid
				# Merge, & then build, a coherent configuration model
				return buildConfiguration(areConfigsValid, deserializedConfigs, mergeConfigurations(deserializedConfigs))
			else 
				raise "Configurations did not pass validation."
			end

		end # End def BuildConfig
		
		# Description::	Static method, called on the factory to build a configuration repository,
		#				after loading, deserializing, validating, merging, & building a complete 
		#				view of a configuration, defined in a default, as well as an override, 
		#				JSON file. If you want this factory to properly validate the JSON 
		#				configuration files, please ensure that the files reference a JSON 
		#				schema document, in the $schema property
		# Parameters::	
		#	(String) defaultFilePath: a collection containing the deserialized configuration files
		#	(String) overrideFilePath: a collection containing the deserialized configuration files
		# Return Type::	Configuration Repository
		def BuildConfigRepo(defaultFilePath, overrideFilePath)
			return ConfigurationRepository.new(self.BuildConfig(defaultFilePath, overrideFilePath))
		end # End def BuildConfigRepo

		# Description::	Used to load & deserialize the default & override JSON configuration files
		# Parameters::	
		#	(String) defaultFilePath: a collection containing the deserialized configuration files
		#	(String) overrideFilePath: a collection containing the deserialized configuration files
		# Return Type::	Ruby.Hash
		private def loadConfigurationFiles(defaultFilePath, overrideFilePath)

			configs = {}
		
			# Check if the default JSON configuration document exists, 
			if File.exists?(File.expand_path(defaultFilePath))
				# If it does, read & deserialize it into the configs hash
				configs[Configuration::DEFAULTS_KEY] = JSON.parse(File.read(File.expand_path(defaultFilePath)))
			else
				# Else, throw an error
				raise "Default Configuration file not found."
			end # End if File.exists
			# End load & deserialization of defaults JSON configuration document
			
			# Check if the overrides JSON configuration document exists, 
			if File.exists?(File.expand_path(overrideFilePath))
				# If it does, read & deserialize it into the configs hash
				configs[Configuration::OVERRIDES_KEY] = JSON.parse(File.read(File.expand_path(overrideFilePath)))
			else
				# Else, throw an error
				raise "Override Configuration file not found."
			end # End if File.exists
			# End load & deserialization of overrides JSON configuration document
		
			return configs
		
		end # End private def loadConfigurationFiles

		# Description::	Used to validate the JSON found in the default & override configuration files
		# Parameters::	
		#	(String) defaultFilePath: a collection containing the deserialized configuration files
		#	(String) overrideFilePath: a collection containing the deserialized configuration files
		# Return Type::	Ruby.Boolean
		private def validateConfigurationFiles(deserializedConfigs)

			# Validate the defaults configuration collection
			if !ConfigurationValidator::ValidateConfiguration(deserializedConfigs[Configuration::DEFAULTS_KEY])
				raise "Default Configuration file is not valid."
			end # End if config is valid
			# End the validation of the defaults configuration collection
			
			# Validate the overrides configuration collection
			if !ConfigurationValidator::ValidateConfiguration(deserializedConfigs[Configuration::OVERRIDES_KEY])
				raise "Override Configuration file is not valid."
			end # End if config is valid 
			# End the validation of the overrides configuration collection

			return true

		end # End private def validateConfigurationFiles
		
		# Description::	Used to merge the results from deserialization of the default & override configuration files
		# Parameters::	
		#	(Hash) deserializedConfigs: a collection containing the deserialized configuration files
		# Return Type::	Ruby.Hash
		private def mergeConfigurations(deserializedConfigs)
			
			merged = {}
		
			# Begin merging the default & override vagrant configurations
			merged[Configuration::VAGRANT_KEY] = deserializedConfigs[Configuration::DEFAULTS_KEY][Configuration::VAGRANT_KEY]

			if !deserializedConfigs[Configuration::OVERRIDES_KEY][Configuration::VAGRANT_KEY].nil?
				merged[Configuration::VAGRANT_KEY] = merged[Configuration::VAGRANT_KEY].mergeCollections(deserializedConfigs[Configuration::OVERRIDES_KEY][Configuration::VAGRANT_KEY])
			end 
			# End merging the default & override vagrant configurations
		
			# Begin merging the default & override server configurations
			merged[Configuration::SERVERS_KEY] = []

			# Loop through each server definition in the override configuration collection
			deserializedConfigs[Configuration::OVERRIDES_KEY][Configuration::SERVERS_KEY].each do |server|
				merged[Configuration::SERVERS_KEY].push(deserializedConfigs[Configuration::DEFAULTS_KEY][Configuration::SERVERS_KEY].mergeCollections(server))
			end # End server.each
			# End merging the default & override server configurations

			return merged

		end # End private def mergeConfigurations
		
		# Description::	Used to new-up a Configuration object using a flag indicating whether the
		#				configuration files were found to be valid, the deserialized configuration 
		#				collections, as well as the result of merging the deserializations of those files
		# Parameters::	
		# 	(Boolean) areConfigsValid: a flag indicating whether the configuration files were found to be valid
		#	(Hash) deserializedConfigs: a collection containing the deserialized configuration files
		#	(Hash) mergedConfigs: a collection containing the result of merging the deserialized hashes
		# Return Type::	Configuration model
		private def buildConfiguration(areConfigsValid, deserializedConfigs, mergedConfigs)
			return Configuration.new(areConfigsValid, deserializedConfigs, mergedConfigs)
		end # End private def buildConfiguration
	
	end # End class << self

end # End class ConfigurationFactory
