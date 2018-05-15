# codeSnips.R

# ===== A function to make dinucleotides =======================================

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

# ====== Impoving the function =================================================
# Better code:
# The less "pedestrian version" is to use paste in asmarter way.
# Vectors that are paste()'ed are joined element by element:

paste(c("A", "B", "C"), c("D", "E", "F"), sep = ":")  # "A:D" "B:E" "C:F"
paste(1:3, 4:6, 7:9)   # "1 4 7" "2 5 8" "3 6 9"

# Exmple: paste together all 64 codons from different repeating patterns of
# nucleotides

# define
n1 <-     c(rep("A",16), rep("C",16), rep("G",16), rep("T",16)))
n2 <- rep(c(rep("A", 4), rep("C", 4), rep("G", 4), rep("T", 4)), 4))
n3 <- rep(c(    "A",         "C",         "G",         "T"),    16))

# confirm
paste(n1, collapse = "")
paste(n2, collapse = "")
paste(n3, collapse = "")

# collate
paste(n1, n2, n3,  sep = "")



# So we can write a super simple expression for our dinucleotides

dinucVector <- function(x) {
    # create a vector of dinucleotides from a nucleotide sequence vector
    idx <- 1:(length(x) - 1)
    return(paste(x[idx], x[idx + 1], sep=""))
}

# test it:
dinucVector(mySeq[1:20])

# Task: - can you make a function for trinucleotides?
#       - can you make non-overlapping trinucleotides (i.e. collate a
#         sequence vector into codons?)


# ====== Barplot things ========================================================
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
