
require 'json'

class Logger

	def Logger.LogToConsole(object, isJson)

		if isJson # Is this object a JSON collection, then use JSON.pretty_generate
			puts JSON.pretty_generate(object)
		else # Else just print the object to the console
			puts object
		end # end if isJson

	end # end def logToConsole

end # end class Logger
