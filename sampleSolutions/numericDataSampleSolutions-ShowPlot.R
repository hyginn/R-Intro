# numericDataSampleSolutions-ShowPlot.R
#
# Purpose: show the final plot for the Numeric Data unit
# Version: 1.0
# Date:    2018-05-10
# Author:  Boris Steipe
#
# Input:   NA
# Output:  NA - plot as side-effect
# Dependencies: ./sampleSolutions/dat16f119.RData must exist
#
# ToDo:
# Notes:
#
# ==============================================================================

# prepare with 16f119 key
#
# dPhiPsi16f119 <- dPhiPsi
# myColorRamp16f119 <- myColorRamp
# save("dPhiPsi16f119", "myColorRamp16f119",
#       file = "./sampleSolutions/dat16f119.RData")

# load
load("./sampleSolutions/dat16f119.RData")

if (! require(plot3D, quietly=TRUE)) {
    install.packages("plot3D")
    library(plot3D)
}

# example with custom tickmarks
# cf http://entrenchant.blogspot.ca/2014/03/custom-tick-labels-in-r-perspective.html


# define a function to keep all variables local
plot16f119 <- function(dPhiPsi, myColorRamp) {

    minX <- -180
    maxX <-  180
    xPos <- seq(minX, maxX, by = 60)
    minY <- minX
    maxY <- maxX
    yPos <- xPos

    zScale <- 500000
    minZ <- 0
    maxZ <- 150
    zPos <- seq(minZ, maxZ, by=50)

    # draw the plot, save the perspective matrix
    pMat <- persp3D(z = dPhiPsi$z * zScale,
                    x = dPhiPsi$x,
                    y = dPhiPsi$y,
                    xlab = "phi",
                    ylab = "psi",
                    zlab = "density",
                    main = "phi/psi plot of 6AU6",
                    axes = FALSE,
                    theta = 50,
                    phi = 15,
                    expand = 2,
                    facets = TRUE,
                    scale = FALSE,
                    col = myColorRamp(40),
                    shade = 0.2,
                    border = "#FFFFFF22",
                    clab = "density",
                    colkey = list(side = 4, length = 0.6))


    # Transformed axes are drawn "by hand" from lines(), segements(), and text()
    # given the transformation matrix pMat that is returned by the plot.
    #
    # draw the axis lines
    lines(trans3d(xPos, minY, minZ, pMat) , col="#222255", lwd = 3)
    lines(trans3d(maxX, yPos, minZ, pMat) , col="#222255", lwd = 3)
    lines(trans3d(minX, minY, zPos, pMat) , col="#222255", lwd = 3)


    # draw tick marks
    tickLength <- (maxX - minX) * 0.05
    tickStart <- trans3d(xPos,  minY,               minZ, pMat)
    tickEnd   <- trans3d(xPos, (minY - tickLength), minZ, pMat)
    segments(tickStart$x, tickStart$y, tickEnd$x, tickEnd$y)

    tickStart <- trans3d( maxX,               yPos, minZ, pMat)
    tickEnd   <- trans3d((maxX + tickLength), yPos, minZ, pMat)
    segments(tickStart$x, tickStart$y, tickEnd$x, tickEnd$y)

    tickStart <- trans3d(minX,                minY, zPos, pMat)
    tickEnd   <- trans3d(minX, (minY - tickLength), zPos, pMat)
    segments(tickStart$x, tickStart$y, tickEnd$x, tickEnd$y)


    # add tick mark labels
    labelOffset <- (maxX - minX) * 0.075
    labelPos <- trans3d(xPos, (minY - labelOffset), minZ, pMat)
    text(labelPos$x, labelPos$y,
         labels = as.character(xPos),
         adj = c(0, NA), srt = 270, cex = 0.6)

    labelPos <- trans3d((maxX + labelOffset), yPos, minZ, pMat)
    text(labelPos$x, labelPos$y,
         labels = as.character(xPos),
         adj = c(0, NA), cex = 0.6)

    labelPos <- trans3d(minX, (minY - labelOffset), zPos, pMat)
    text(labelPos$x, labelPos$y,
         labels = as.character(zPos),
         adj = c(1, NA), cex = 0.6)

}

plot16f119(dPhiPsi16f119, myColorRamp16f119)



# clean up
rm(plot16f119)
rm(dPhiPsi16f119)
rm(myColorRamp16f119)


# [END]
