
####################################################################################################
# Title::		Collection Extensions: Ruby Collection Extension Methods
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	Adds extension methods to Ruby's collection classes for ease-of-use
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of Collection extensions & documentation
####################################################################################################

class Hash

	def mergeCollections(override_hash)

		self.merge(override_hash) do |key, global_value, override_value|

			# If the global value is ofType "Hash", recurse through it
			if global_value.is_a?(Hash)
				global_value.mergeCollections(override_value)

			# Else if the global value is ofType "Array", merge the two Arrays
			# Thought: Could this possibly cause collisions between values that should be overridden?
			elsif global_value.is_a?(Array)
				global_value.push(*override_value)

			# Else, if the override value exists, take it, otherwise use the global value
			else
				override_value.nil? ? global_value : override_value
			end # end if global_value.is_a?([Hash|Array])

		end # end self.merge

	end # end def mergeCollections

	# Accept a string, delimited by '/', to drill down to get the intended value
	
end # end class Hash
