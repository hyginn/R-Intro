# typeInfo.R
#
# Purpose:  information about an R object
##
# ==============================================================================

typeInfo <- function(x) {
	# Purpose:
	#     Detailed information about an R object
    # Version: 1.0
    # Date:    2016 06 01
    # Author:  b
    #
    # Parameters:
	#     x: an R object
	# Value:
	#     no return values. Information is printed as a side-effect
	#
    print(x, digits=22)
    cat("str:    ")
    str(x)
    cat("mode:   ", mode(x), "\n")
    cat("typeof: ", typeof(x), "\n")
    cat("class:  ", class(x), "\n")
    # if there are attributes, print them too
    if (! is.null(attributes(x))) {
        cat("attributes:\n")
        print(attributes(x))
    }
}


# [END]
