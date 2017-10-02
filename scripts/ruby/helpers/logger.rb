
####################################################################################################
# Title::		Logger: Logger method collection
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	Logging methods to provided to output information, cleanly
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of Logger & documentation
####################################################################################################

require 'json'

class Logger

	# Description::	Public static method used to log messages to the console. If the isJSON flag 
	# 				is set to true, the method will beautify the output to the console. 
	# Parameters::	
	#	(object) object:	an object or message intended to be printed to the console
	#	(Bool) isJSON: 		a flag indicating that the object is expected to be valid JSON, and 
	#						should be formatted as such.
	def self.LogToConsole(object, isJSON)

		# Check if this object a JSON collection 
		if isJSON 
			# If so, then use JSON.pretty_generate to format the output
			puts JSON.pretty_generate(object)
		else 
			# Else, just print the object to the console, normally
			puts object
		end # End if isJSON

	end # End def logToConsole

end # End class Logger
