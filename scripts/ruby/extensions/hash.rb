
# Add Extension methods to the ruby base Hash class
class Hash

	def mergeConfigurations(override_hash)

		self.merge(override_hash) do |key, global_value, override_value|

			# If the global value is ofType "Hash", recurse through it
			if global_value.is_a?(Hash)
				global_value.mergeConfigurations(override_value)

			# Else if the global value is ofType "Array", merge the two Arrays
			# Thought: Could this possibly cause collisions between values that should be overridden?
			elsif global_value.is_a?(Array)
				global_value.push(*override_value)

			# Else, if the override value exists, take it, otherwise use the global value
			else
				override_value.nil? ? global_value : override_value
			end # end if global_value.is_a?([Hash|Array])

		end # end self.merge

	end # end def mergeConfigurations

	# Accept a string, delimited by '/', to drill down to get the intended value
	
end # end class Hash