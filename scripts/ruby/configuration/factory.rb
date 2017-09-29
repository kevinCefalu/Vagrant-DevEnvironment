
####################################################################################################
# Title::		Configuration Factory: VagrantFile Configuration model factory
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	A factory for loading, validating, deserializing, merging, 
# 				and building a Configuration model for consumption in a VagrantFile
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of ConfigurationFactory & documentation
####################################################################################################

require 'json'
require_relative "model.rb"
require_relative "../helpers/configuration.rb"
require_relative "../helpers/collections.rb"
require_relative "../helpers/logger.rb"

class ConfigurationFactory

	class << self

		# Description::	Local copies of Configuration hash keys, used 
		#				mostly just to make lines a little more terse
		private _defaultsKey = Configuration::DEFAULTSKey
		private _overridesKey = Configuration::OVERRIDESKey
		private _vagrantKey = Configuration::VAGRANTKey
		private _serversKey = Configuration::SERVERSKey

		# Description::	Static method, called on the factory to validate, load, deserialize, 
		# 				merge, and build a complete view of a configuration, defined in a 
		#				default, as well as an override, JSON file. If you want this factory
		#				to properly validate the JSON configuration files, please ensure that
		# 				the files reference a JSON schema document, in the $schema property
		# Parameters::	
		#	(String) defaultFilePath: a collection containing the deserialized configuration files
		#	(String) overrideFilePath: a collection containing the deserialized configuration files
		# Return Type::	Configuration model
		def BuildConfig(defaultFile, overrideFile)

			areConfigsValid = validateConfigFiles(defaultFile, overrideFile)

			if areConfigsValid
			then
				deserializedConfigs = loadConfigFiles(defaultFile, overrideFile)

				return buildConfiguration(areConfigsValid, 
					deserializedConfigs, mergeConfigurations(deserializedConfigs))
			end

		end

		# Description::	Used to validate the JSON found in the default and override configuration files
		# Parameters::	
		#	(String) defaultFilePath: a collection containing the deserialized configuration files
		#	(String) overrideFilePath: a collection containing the deserialized configuration files
		# Return Type::	Ruby.Boolean
		private def validateConfigFiles(defaultFilePath, overrideFilePath)

			# TODO: Use $Schema property found in each JSON document
			# if File.exists?(File.expand_path(defaultFilePath))
			# 	if !JSON.valid?(File.read(File.expand_path(defaultFilePath)))
			# 		raise "Default Configuration file is not valid."
			# 	end
			# else
			# 	raise "Default Configuration file not found."
			# end
			
			# if File.exists?(File.expand_path(overrideFilePath))
			# 	if !JSON.valid?(File.read(File.expand_path(overrideFilePath)))
			# 		raise "Override Configuration file is not valid."
			# 	end
			# else
			# 	raise "Override Configuration file not found."
			# end

			return true

		end # end private def validateConfigFiles

		# Description::	Used to merge the results from deserialization of the default and override configuration files
		# Parameters::	
		#	(String) defaultFilePath: a collection containing the deserialized configuration files
		#	(String) overrideFilePath: a collection containing the deserialized configuration files
		# Return Type::	Ruby.Hash
		private def loadConfigFiles(defaultFilePath, overrideFilePath)

			configs = {}
		
			if File.exists?(File.expand_path(defaultFilePath))
				configs[_defaultsKey] = JSON.parse(File.read(File.expand_path(defaultFilePath))
			else
				raise "Default Configuration file not found."
			end
			
			if File.exists?(File.expand_path(overrideFilePath))
				configs[_overridesKey] = JSON.parse(File.read(File.expand_path(overrideFilePath))
			else
				raise "Override Configuration file not found."
			end
		
			return configs
		
		end # end private def loadConfigFiles
		
		# Description::	Used to merge the results from deserialization of the default and override configuration files
		# Parameters::	
		#	(Hash) deserializedConfigs: a collection containing the deserialized configuration files
		# Return Type::	Ruby.Hash
		private def mergeConfigurations(deserializedConfigs)

			merged = {}
		
			# Merge Vagrant Configurations
			merged[_vagrantKey] = deserializedConfigs[_defaultsKey][_vagrantKey]

			if !deserializedConfigs[_overridesKey][_vagrantKey].nil?
				merged[_vagrantKey] = merged[_vagrantKey].mergeCollections(deserializedConfigs[_overridesKey][_vagrantKey])
			end # end Merging of Vagrant Configurations
		
			# Merge Server Configurations
			merged[_serversKey] = []

			deserializedConfigs[_overridesKey][_serversKey].each do |server|
				merged[_serversKey].push(deserializedConfigs[_defaultsKey][_serversKey].mergeCollections(server))
			end # end Merging of Server Configurations

			return merged

		end # end private def mergeConfigurations
		
		# Description::	Used to new-up a Configuration object using a flag indicating whether the
		#				configuration files were found to be valid, the deserialized configuration 
		#				files, as well as the result of merging the deserializations of those files
		# Parameters::	
		# 	(Boolean) areConfigsValid: a flag indicating whether the configuration files were found to be valid
		#	(Hash) deserializedConfigs: a collection containing the deserialized configuration files
		#	(Hash) mergedConfigs: a collection containing the result of merging the deserialized hashes
		# Return Type::	Configuration model
		private def buildConfiguration(areConfigsValid, deserializedConfigs, mergedConfigs)
			
			return Configuration.new(areConfigsValid, deserializedConfigs, mergedConfigs)
		
		end # end public def buildConfiguration
	
	end # end class << self

end # end class ConfigurationFactory
