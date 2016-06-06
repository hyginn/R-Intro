# biCodes.R
#
# Purpose:  Produce a binomial name from a string
#
# ToDo: - handle case if there is only one word in the input
#       - fail gracefully if input is not a string
#
# ==============================================================================

biCodes <- function(s) {
    # Purpose:
    #     Produce a binomial name from a string that contains at least
    #     two words.
    # Version:  1.0
    #
    # Parameters:
	#     s: a single string
	# Value:
	#     v: an upper-case binomial code derived from
	#        the n-first and n-second letters in the first two
	#        words of the input string

    nFirst  <- 3
    nSecond <- 2
    y <- strsplit(toupper(s), " ")
    v <- paste(substr(y[[1]][1], 1, nFirst),
               substr(y[[1]][2], 1, nSecond),
               collapse='', sep='')
    return(v)
}


# ====  TESTS  =================================================================

biCodes("Homo sapiens")
biCodes("Drosophila melanogaster")
biCodes("Fugu rubripens")


# [END]
