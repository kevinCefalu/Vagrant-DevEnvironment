
####################################################################################################
# Title::		String Extensions: Ruby String Extension Methods
# Author::		Kevin Cefalu  (mailto:kevin.cefalu@gmail.com)
# CreatedOn::	2017-09-25
# Description::	Adds extension methods to Ruby's String class for ease-of-use
####################################################################################################
# Changelog::
# Date			By				Description
#--------------|---------------|---------------------------------------------------------------------
# 2017-09-25	KCefalu			Initial creation of String extensions & documentation
####################################################################################################

class String
	
	# Description::	Use this method to test whether, or not, a string can be cast to an integer
	# Parameters::	
	#	(string) self: a string that may or may not be able to be cast to an integer
	# Return Type::	Ruby.Boolean
	def is_i?
		/\A[-+]?\d+\z/ === self
	end # End def is_i?

end # End class String
