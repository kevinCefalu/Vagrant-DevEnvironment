
####################################################################################################
# Title::		Configuration Extensions: Configuration model & Repo Extension Methods
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	Adds extension methods to the Configuration model for ease-of-use
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of Configuration model extensions & documentation
####################################################################################################

require_relative "string.rb"

class ConfigurationExtensions
	
	def self.GetValueFromPath(collection, jsonPathString)
		
		pathArray = jsonPathString.split('/')
		currentKey = pathArray.shift

		# puts currentKey
		# puts pathArray.length

		if pathArray.length == 0
			
			if collection.is_a?(Hash)
				return collection[currentKey]
			elsif collection.is_a?(Array)
				if currentKey.is_i?
					return collection[currentKey.to_i]
				else
					raise "Invalid arrray index: couldnt convert string to integer (index)."
				end
			else
				raise "Invalid collection."
			end
				
		else
			if collection.is_a?(Hash)
				return self.getValueFromPath(collection[currentKey], pathArray.join('/'))
			elsif collection.is_a?(Array)
				if currentKey.is_i?
					return self.getValueFromPath(collection[currentKey.to_i], pathArray.join('/'))
				else
					raise "Invalid arrray index: couldnt convert string to integer (index)."
				end
			else
				raise "Invalid collection."
			end

		end # end if pathArray.length check

	end # end def self.GetValueFromPath

end
