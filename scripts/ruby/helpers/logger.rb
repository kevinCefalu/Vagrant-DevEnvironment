
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

	def self.LogToConsole(object, isJson)

		if isJson # Is this object a JSON collection, then use JSON.pretty_generate
			puts JSON.pretty_generate(object)
		else # Else just print the object to the console
			puts object
		end # end if isJson

	end # end def logToConsole

end # end class Logger
