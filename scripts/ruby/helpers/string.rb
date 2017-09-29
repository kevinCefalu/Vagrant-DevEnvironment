
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
	
	def is_i?
		/\A[-+]?\d+\z/ === self
	end

end
