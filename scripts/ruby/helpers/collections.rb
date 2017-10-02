
####################################################################################################
# Title::		Collection Extensions: Ruby Collection Extension Methods
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	Adds extension methods to collection classes for ease-of-use
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of Collection extensions & documentation
####################################################################################################

require_relative "string.rb"

class Hash

	# Description::	Merge function that recursively turns through a hash & overrides values 
	#				when an override is found, & merge arrays when an array traversed
	# Parameters::	
	#	(String) jsonPath: 	a string representation of the path needed to traverse to the target property
	def mergeCollections(override_hash)

		self.merge(override_hash) do |key, global_value, override_value|

			if global_value.is_a?(Hash)
				# If the global value is ofType "Hash", recurse through it
				global_value.mergeCollections(override_value)
			elsif global_value.is_a?(Array) && override_value.is_a?(Array)
				# Else if the global value is ofType "Array", merge the two Arrays
				# TODO: Implement a unique identifier to ensure that values in the array can be overridden
				override_value.push(*global_value)
			else
				# Else, if the override value exists, take it, otherwise use the global value
				override_value.nil? ? global_value : override_value
			end # End if global_value.is_a?([Hash|Array])

		end # End self.merge

	end # End def mergeCollections
	
end # End class Hash

class Collection
	
	class << self

		# Description::	Public method used to query the merged configuration hash by providing a 
		#				string representation of the path needed to traverse to the target property
		# Parameters::	
		#	(Hash) collection:	a collection that you wish to traverse using the provided path
		#	(String) jsonPath: 	a string representation of the path needed to traverse to the target property
		#						I.e., "Vagrant/host_locale" for values in a hash, or "Servers/0/hostname".
		#						Note the '0', which is used to indicate the indice of the array "Servers".
		# Return Type::	Depends on the value found at the path (but likely serialized to Ruby.String)
		def GetValueFromPath(collection, jsonPathString)
			
			# Split & shift the first array element (key) into a local variable
			pathArray = jsonPathString.split('/')
			currentKey = pathArray.shift

			# Check if the collection should go any deeper.
			if pathArray.length > 0
				# if so, recurse deeper into the target node, in the current node
				return collectionLogicBranch(collection, currentKey, pathArray, Proc.new { 
					|collection, key, pathArray| return self.GetValueFromPath(collection[key], pathArray.join('/')) })
			else
				# if not, return the target leaf's value, in the current node
				return collectionLogicBranch(collection, currentKey, pathArray, Proc.new { 
					|collection, key, pathArray| return collection[key] })
			end # End if pathArray.length check

		end # End def GetValueFromPath

		# Description::	Private method used to abstract out branching logic that was duplicated.
		#				Checks if the collection parameter is a hash or an array, and then calls 
		#				a Proc statement provided in the method parameters, to either return the
		#				current node's targeted value, or recursively drill deeper into the collection
		# Parameters::	
		#	(Hash|Array) collection:	a collection that to traverse using the provided keys in the form of a path
		#	(String|Int) currentKey:	the current node's targeted property key
		#	(Array) pathArray:			an array of keys used to traverse the collection 
		#	(Proc) commandProc:			a command closure (Proc) that specifies logic for the branch
		# Return Type::	Depends on the value found at the path (but likely serialized to Ruby.String)
		private def collectionLogicBranch(collection, currentKey, pathArray, commandProc)
			# Check if the current collection node is a Hash or an array 
			if collection.is_a?(Hash)
				# If it's a hash, pass the parameters into the command proc
				return commandProc.call(collection, currentKey, pathArray)
			elsif collection.is_a?(Array)
				# If it's an array, check if the currentKey parameter is an integer
				# If it is, convert the key to an integer, & then pass the parameters into the command proc
				return commandProc.call(collection, currentKey.to_i, pathArray) if currentKey.is_i?
				# Else, throw an error
				raise "Invalid arrray index: couldnt convert string to integer (index)."
			else
				# Something bad has happened. It's likely that your path was malformed, or incorrect.
				raise "Invalid collection."
			end # End if
	
		end # End def collectionCheckBranch

	end # End class << self

end # End class Collection
