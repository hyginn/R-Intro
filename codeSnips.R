# codeSnips.R

dinucVector <- function(x) {
    # create a vector of dinucleotides from a sequence vector
    # (pedestrian version)
    iFrom <- 1:(length(x) - 1)
    iTo <- 2:length(x)

    dinuc <- character(length(iFrom))

    for (i in 1:length(iFrom)) {
        dinuc[i] <- paste(x[iFrom[i]], x[iTo[i]], sep = "")
    }
    return(dinuc)
}

dinuc <- dinucVector(mySeq)
tObs <- table(dinuc)

dinucRand <- dinucVector(sample(mySeq))
tRand <- table(dinucRand)


# [end]
