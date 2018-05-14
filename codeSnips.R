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

# Barplot things:
sortedNames <- names(sort(tObs, decreasing = TRUE))

tObs[sortedNames]
tRand[sortedNames]


barplot(tObs[sortedNames]/sum(tObs),
        col = "#0070AA55",
        cex.names = 0.45)

barplot(tRand[sortedNames]/sum(tRand),
        col = "#DD005555",
        add = TRUE,
        axisnames = FALSE)

legend("topright",
       c("Observed", "Randomized"),
       cex = 0.8,
       fill = c("#0070AA55","#DD005555"),
       border = "#000000")




# [end]
