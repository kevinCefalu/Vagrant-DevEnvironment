
class ConfigurationExtensions

	def self.getValueFromPath(collection, jsonPathString)
		
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

	end # end def getValueFromPath

end
