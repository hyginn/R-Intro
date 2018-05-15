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

# =    5  PLOT THE DATA  =======================================================
#
# Time for a Lolliplot

# Task 5.1 What categories of effects do we have?
unique(GNAS2mut$MOST_SEVERE)

# Task 5.2 Define colors for the categories - (Hint: pick a palette e.g. with
#          https://color.adobe.com/ You are looking for a divergent spectrum
#          that emphasizes similar vs. different effects.
#
#          e.g. "#D42823AA"      # "frameshift_variant"
#               "#FC7B14AA"      # "missense_variant"
#               "#ED69A7AA"      # "stop_gained"
#               "#CAD1FAAA"      # "synonymous_variant"
#
#          - also define a color for a rectangle that symbolizes the
#            protein:
colProtein <- "#82A2D1"

#          - to work with the effect categories, put them into a
#            data frame: eff$effects - the effects
#                        eff$cols    - the colours
#                        eff$heights - the vertical positions
#          - give the data frame rownames of the effects, so it's easy
#            to fetch data by rowname

eff <- data.frame( effects = sort(unique(GNAS2mut$MOST_SEVERE)),
                   cols = c("#D42823A3",   # "frameshift_variant"
                            "#FC7B14A3",   # "missense_variant"
                            "#ED69A7A3",   # "stop_gained"
                            "#CAD1FAA3"),  # "synonymous_variant"
                   heights = c(1.7, 3.0, 2.3, 1.0),
                   stringsAsFactors = FALSE)
rownames(eff) <- eff$effect

#  >>> let's verify our colors: looking good?
barplot(rep(10, 4),
        axes = FALSE,
        names.arg = eff$effects,
        las = 2,
        cex.names = 0.5,
        col = eff$cols)


# Task 5.3 Compile the mutations by amino acid and mutation type.
#          - define a matrix with rows for each mutated position,
#            columns for each effect category. Give it rownames() of
#            positions, colnames() of effects - so we can easily
#            access data by position and mutation type. Call the matrix
#            mMut

sel <- which(GNAS2protein$coords %in% GNAS2mut$START)
positions <- unique(GNAS2protein$iCodon[sel])
mMut <- matrix(numeric(length(positions) * nrow(eff)), ncol = nrow(eff))
rownames(mMut) <- positions
colnames(mMut) <- eff$effects

#          - iterate over all mutations, find which sequence position it
#            affects with which effect, and increment the value you find
#            in the mMut matrix.

for (i in 1:nrow(GNAS2mut)) {
    sel <- which( GNAS2protein$coords  %in% GNAS2mut$START[i])
    pos <- as.character(GNAS2protein$iCodon[sel])
    e <- GNAS2mut$MOST_SEVERE[i]
    mMut[pos, e] <- mMut[pos, e] + 1
}

# Task 5.4 Prepare for plotting.
#          - How do we draw circles on the plot?

# >>> We could use the draw.circle() function in the
# plotrix package - but that won't work if we don't take care to set the aspect
# ratio of the plot to 1. Better to use plotting symbols and vary their size.
# The symbol we need is number 21:
plot(1:4,
     rep(1,4),
     pch = 21,
     xlim = c(0, 5),
     axes = FALSE, xlab = "", ylab = "",
     cex = seq(1, 8, length.out = 4),
     col = "#555555",
     bg = eff$cols)


#          - What size should the circles have?
# >>> write a function to calculate plot symbol sizes
n2cex <- function(n, nMax) {
    cMax <- 5
    return((n / nMax) * cMax)
}

#          - How do we put graphic elements on a plot in principle?
#          (Hint: draw an empty plot of the correct size, then add
#                 lines(), points(), rectangle(), polygon() or text().
#                 Also add axes(). And a legend. And a title.)



# Task 5.4 Define a layout - x, and y ddimensions
# >>> x- axis from 0 to sequence length + 1
#     y axis from 0 to 5, centering the four circle categories on 1 to 4
#
# Task 5.5. Plot ...
#           - an empty frame to setup the coordinates...
plot(0, 0,
     type = "n",
     xlim = c(0, ceiling(max(GNAS2protein$iCodon) / 100) * 100),
     ylim = c(0, nrow(eff) + 2),
     xlab = "GNAS-2 sequence position",
     ylab = "",
     main = "CDS mutations by effect and frequency",
     axes = FALSE)

#            - draw a rectangle for the protein ...
rect(xleft = 1,
     ybottom = 0,
     xright = max(GNAS2protein$iCodon),
     ytop = 0.15,
     col = colProtein)

#           - and an axis at the bottom ...
axis(side = 1)


#            -  then plot the mutations for all positions and categories ...
nMax <- max(mMut)

for (i in 1:nrow(mMut)) {
    for (j in 1:ncol(mMut)) {
        if ((n <- mMut[i, j]) > 0) {
            x <- as.numeric(rownames(mMut)[i])
            y <- eff[colnames(mMut)[j], "heights"]
            thisCol <- eff[colnames(mMut)[j], "cols"]
            # draw a line
            lines(c(x, x), c(0.15, y), col = "#00000033")
            # draw the circle
            points(x, y, pch = 21, cex = n2cex(n, nMax), bg = thisCol)
        }
    }
}

#            - finally, plot a legend
# >>> order it correctly
ord <- order(eff$heights, decreasing = TRUE)
legend("topright",
       eff$effects[ord],
       cex = 0.9,
       fill = eff$cols[ord],
       bty = 'n',
       border = "#000000")



# [end]
