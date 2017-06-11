# .init.R
# Functions to initialize this Exercise session
# Boris Steipe
# ====================================================================

# Create a local copy of myScript.R if that hasn't been done yet.
if (! file.exists("myScript.R")) {
    file.copy("tmp.R", "myScript.R")
}

# source(".utilities.R")

file.edit("R-Intro.R")

# [End]
