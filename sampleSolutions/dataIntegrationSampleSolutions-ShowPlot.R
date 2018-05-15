# dataIntegrationSampleSolutions-ShowPlot.R
#
# Purpose: show the final plot for the data integration unit
# Version: 1.0
# Date:    2018-05-10
# Author:  Boris Steipe
#
# Input:   NA
# Output:  NA - plot as side-effect
# Dependencies: ./sampleSolutions/dat374378bc0.RData must exist
#
# ToDo:
# Notes:
#
# ==============================================================================

# Prepare:
# eff374378bc0 <- eff
# GNAS2protein374378bc0 <- GNAS2protein
# mMut374378bc0 <- mMut
# n2cex374378bc0 <- n2cex
# colProtein374378bc0 <- colProtein
#
# save("eff374378bc0",
#      "GNAS2protein374378bc0",
#      "mMut374378bc0",
#      "n2cex374378bc0",
#      "colProtein374378bc0",
#      file = "./sampleSolutions/dat374378bc0.RData")

# load
load("./sampleSolutions/dat374378bc0.RData")

# plot
plot(0, 0,
     type = "n",
     xlim = c(0, ceiling(max(GNAS2protein374378bc0$iCodon) / 100) * 100),
     ylim = c(0, nrow(eff374378bc0) + 2),
     xlab = "GNAS-2 sequence position",
     ylab = "",
     main = "CDS mutations by effect and frequency",
     axes = FALSE)

#            - draw a rectangle for the protein ...
rect(xleft = 1,
     ybottom = 0,
     xright = max(GNAS2protein374378bc0$iCodon),
     ytop = 0.15,
     col = colProtein374378bc0)

#           - and an axis at the bottom ...
axis(side = 1)


#            -  then plot the mutations for all positions and categories ...
nMax374378bc0 <- max(mMut374378bc0)

for (i in 1:nrow(mMut374378bc0)) {
    for (j in 1:ncol(mMut374378bc0)) {
        if ((n <- mMut374378bc0[i, j]) > 0) {
            x <- as.numeric(rownames(mMut374378bc0)[i])
            y <- eff374378bc0[colnames(mMut374378bc0)[j], "heights"]
            thisCol <- eff374378bc0[colnames(mMut374378bc0)[j], "cols"]
            # draw a line
            lines(c(x, x), c(0.15, y), col = "#00000033")
            # draw the circle
            points(x, y, pch = 21,
                   cex = n2cex374378bc0(n, nMax374378bc0),
                   bg = thisCol)
        }
    }
}

ord <- order(eff374378bc0$heights, decreasing = TRUE)
legend("topright",
       eff374378bc0$effects[ord],
       cex = 0.9,
       fill = eff374378bc0$cols[ord],
       bty = 'n',
       border = "#000000")

# clean up
rm(eff374378bc0)
rm(GNAS2protein374378bc0)
rm(mMut374378bc0)
rm(n2cex374378bc0)
rm(colProtein374378bc0)
rm(nMax374378bc0)
rm(i, j, x, y)


# [END]
