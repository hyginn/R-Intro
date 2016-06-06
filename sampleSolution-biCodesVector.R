# biCodesVector.R
#
# Purpose:  Produce a vector of binomial names from a character vector
#
# ToDo: - handle case if there is only one word in the input
#       - fail gracefully if input is not a string
#
# ==============================================================================

# The function pattern:
biCodesV <- function(s) {
    # initialize a vector
    # loop over the input
    # collect the code
    # return the result
}

biCodesV <- function(s) {
    # Purpose:
    #     Produce a binomial name from a string that contains at least
    #     two words.
    # Version:  1.0
    #
    # Parameters:
	#     s: a vector of strings
	# Value:
	#     v: a vector of upper-case binomial codes derived from
	#        the n-first and n-second letters in the first two
	#        words of each input string

    nFirst  <- 3
    nSecond <- 2
    v <- character(length(s))
    for (i in 1:length(s)) {
        y <- strsplit(toupper(s[i]), " ")
        v[i] <- paste(substr(y[[1]][1], 1, nFirst),
                      substr(y[[1]][2], 1, nSecond),
                      collapse='', sep='')
    }
    return(v)
}


# ====  TESTS  =================================================================
modelOrganisms <- c(
    "Homo sapiens",
    "Mus musculus",
    "Pan troglodytes",
    "Drosophila melanogaster",
    "Caenorhabditis elegans",
    "Fugu rubripens",
    "Ciona intestinalis",
    "Saccharomyces cerevisiae",
    "Escherichia coli"
)

biCodesV(modelOrganisms)


# [END]
