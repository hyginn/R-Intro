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

# ====== Improving the function ================================================
# Better code:
# The less "pedestrian version" is to use paste in a smarter way.
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

# ===== Ensebl transcripts =====================================================

# read data
GNAStranscripts <- read.csv("./data/ENSG00000087460data.csv",
                            stringsAsFactors = FALSE)

# subset data
sel <- GNAStranscripts$gene_type == "protein_coding"
GNAStranscripts <- GNAStranscripts[ sel , ]

# ENST transcripts only
sel <- grep("^ENST[0-9]{11}$", GNAStranscripts$transcript_id)
GNAStranscripts <- GNAStranscripts[ sel , ]  # 58 different ones


# ===== Integrating the data  ==================================================

# read the GRCh37 gene model data from BioMart
GNASmodels <- read.delim("GNASgeneModels.37.tsv",
                         sep = "\t",
                         stringsAsFactors = FALSE)

# extract the information for ENST00000371095
sel <- GNASmodels$Transcript.stable.ID == "ENST00000371095"
GNAS2model <- data.frame(start = GNASmodels$Genomic.coding.start[sel],
                         end   = GNASmodels$Genomic.coding.end[sel],
                         stringsAsFactors = FALSE)

# careful, transcripts were not ordered in ascending coordinates. Fix that:
ord <- order(GNAS2model$start)
GNAS2model <- GNAS2model[ord, ]




# Task 4.2.2 Create a data frame for GNAS-2 protein annotations, according to
#            the  following specifications:
#
#     -  Call it GNAS2protein
#     -  It should have one row for each nucleotide in the CDS
#     -  Give it the following columns:
#           GNAS2protein$coord     - the genomic coordinates
#           GNAS2protein$nuc       - the actual nucleotide
#           GNAS2protein$codonPos  - 1,2 or 3: the codon position
#           GNAS2protein$aa        - The amino acid (in codon position 1 only)
#           GNAS2protein$iCodon    - The codon index (in all three positions)


mod2coord <- function(m) {
    # gene model to a vector of coordinates
    v <- numeric()
    for (i in 1:nrow(m)) {
        v <- c(v, m$start[i]:m$end[i])
    }
    return(v)
}

OFFSET <- 57410000

GNAS2protein <- data.frame(coords = mod2coord(GNAS2model))
GNAS2protein$nuc <- mySeq37[GNAS2protein$coords - OFFSET]
GNAS2protein$codonPos <- 1:3

tail(GNAS2protein) # looking good


library(seqinr)
x <- translate(GNAS2protein$nuc)
paste(x, collapse = "")  # is this correct?

GNAS2protein$aa <- " "
sel <- which(GNAS2protein$codonPos == 1)
GNAS2protein$aa[sel]     <- translate(GNAS2protein$nuc)

GNAS2protein$iCodon <- floor((0:(nrow(GNAS2protein) - 1)) / 3) + 1


# Task 4.2.2 Create a data frame for GNAS-2 protein mutations, according to
#            the  following specifications:
#     -  Call it GNAS2mut
#     -  Get all rows from GNASmutations where the positions fall
#          into the GNAS-2 CDS

sel <- which(GNASmutations$START %in% GNAS2protein$coords)
GNAS2mut <- GNASmutations[sel, ] # Note: technically, not all of these have been
                                 # observed on the GNAS2 transcript, allthough
                                 # they all fall into the GNAS2 CDS

# >>> confirm that the reference nucleotides are the nucleotides we have
#     in GNAS2protein
idx <- grep("[ACGT]", GNAS2mut$REF)
for (i in idx) {
    cat(sprintf("%d - %s - %s\n",
                GNAS2mut$START[i],
                GNAS2mut$REF[i],
                GNAS2protein$nuc[GNAS2protein$coords == GNAS2mut$START[i]]))
}

table(GNAS2mut$START)  # how many of each?

# >>> Are there codons that are affected more than once?
sel <- which(GNAS2protein$coords %in% GNAS2mut$START)
table(GNAS2protein$iCodon[sel]) # Yes. That would be difficult to tell from
# the mutation table, because different
# transcripts have different lengths.




# [end]
