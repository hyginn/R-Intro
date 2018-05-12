# sequenceAnalysisSampleSolutions-ShowPlot.R
#
# Purpose: show the final plot for the sequence analysis unit
# Version: 1.0
# Date:    2018-05-10
# Author:  Boris Steipe
#
# Input:   NA
# Output:  NA - plot as side-effect
# Dependencies: ./sampleSolutions/dat623b55eca00c.RData must exist
#
# ToDo:
# Notes:
#
# ==============================================================================

# prepare
# rand623b55eca00c <- fRandDiNuc
# ch20623b55eca00c <- ch20DiNucTable
# save("ch20623b55eca00c", "rand623b55eca00c",
#      file = "./sampleSolutions/dat623b55eca00c.RData")

# load
load("./sampleSolutions/dat623b55eca00c.RData")

# plot
barplot(sort(ch20623b55eca00c/sum(ch20623b55eca00c), decreasing = TRUE),
        main = "Dinucleotides: chr20:58815001-58915000",
        ylab = "frequency",
        cex.names = 0.5,
        col = "#0070CC7F")
barplot(rand623b55eca00c[order(ch20623b55eca00c/sum(ch20623b55eca00c),
                         decreasing = TRUE)],
        col = "#DD005555",
        axisnames = FALSE,
        add = TRUE)

abline(h = 1/16, col = "#5555CC33")

legend("topright",
       c("Observed", "Expected"),
       cex = 0.8,
       fill = c("#0070CC7F", "#DD005555"), bty = 'n',
       border = "#000000")

# clean up
rm(rand623b55eca00c)
rm(ch20623b55eca00c)


# [END]
