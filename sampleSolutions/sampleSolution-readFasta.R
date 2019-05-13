# sampleSolution-readFasta.R
#
# Purpose:  Read a FASTA file
#
# Author:   Boris Steipe (boris.steipe@utoronto.ca)
# License:  GPL-3
#
# Date:     2018-05-08
#
# Version:  1.0
#
# Version history:
#   1.0    First version
#
# ToDo:    validations, support multi-FASTA, keep header
#
# Notes:
#
# ==============================================================================

readFasta <- function(FN) {
	# Purpose:
	#     Read a FASTA file
    #
    # Parameters:
	#     FN: char  a fileName
    # Value:
	#     char  a character vector with one sequence letter per element
	# Details:
	#     If FN does not have exactly one header line, which is the first line,
	#     an error is thrown. If there are any characters, other than IUPAC
	#     one-letter codes, "-", or "*", an error is thrown.

    x <- readLines(FN)

    if (! (grepl("^>", x[1]))) {
        stop("Not a FASTA formatted input file.")
    }

    x <- x[-1] # discard header

    if (length(grep("[^A-Za-z*-]", x)) > 0) {
        stop("Non IUPAC letters in input.")
    }

    x <- paste(x, collapse = "")
    x <- strsplit(x, "")[[1]]
    return(x)
}


# ====  EXAMPLES  ==============================================================
# Write your usage examples here...

if (FALSE) {
    myFN <- tempfile()
    writeLines(c(">test", "GAa", "tTC"), myFN)

    readFasta(myFN)
}

# ====  TESTS  =================================================================
# Enter your function tests here...

if (FALSE) {
    # ...
}

# [END]
