require_relative 'currency_util'

# Currency Calculator Main Driver


# For each line of CSV input from $stdin:
#	- chomp the line to remove any end of line characters.
#	- parse into the two currencies and the amount.
#	- convert the amount from string to floating point.
#	- get the converted amount.
#	- print the result as
#	      "<OAMT> in <FC> is <CAMT> in <TC>"
#         where
#           <OAMT>  is the original amount from the input line,	  
#           <FC>    is the from currency identifier string,
#           <CAMT>  is the converted amount, and
#           <TC>    is the to currency identifier string.

$stdin.each do |line|
  ## FILL IN ##
end

