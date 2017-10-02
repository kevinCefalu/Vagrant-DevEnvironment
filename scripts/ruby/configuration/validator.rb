
####################################################################################################
# Title::		Configuration Validator: VagrantFile Configuration Validator
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	A class to provide validation on targeted JSON files, based on 
#				referenced JSON Schema documents
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of ConfigurationValidator & documentation
####################################################################################################

require 'json'
require_relative "../helpers/logger.rb"

class ConfigurationValidator

	class << self

		# Description::	Used to validate a configuration collection that 
		#				has been deserialized from a JSON configuration document
		# Parameters::	
		#	(Hash) configCollection: a collection built by deserializing a JSON configuration file
		# Return Type::	Ruby.Boolean
		def ValidateConfiguration(configCollection)

			# TODO: check if the collection has a $schema property, 
			# check if the path in that property is valid, 
			# deserialize the schema document, & then 
			# validate the configuration collection based on the deserialized schema
			return true

		end # def self.ValidateConfiguration

	end # end class << self

end # end class ConfigurationValidator
