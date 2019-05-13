# scriptTemplate.R
#
# Purpose:
# Version:
# Version history:
# Date:
# Author:
# License:
#
# Input:
# Output:
# Dependencies:
#
# ToDo:
# Notes:
#
# ==============================================================================

# Keep only one of the two notices below, and then remove this line.

# WARNING: SIDE EFFECTS
# Executing this script will execute code it contains.

# NO SIDE EFFECTS:
# This script can be safely source()'d to define the functions it contains and
# install.packages()/run library() as required.
# All other code will not be executed unless this is done interactively.




# Use setwd() with discretion - it should normally not be necessary to change
# the working directory, and it is poor practice since it changes the global
# state. If you must use setwd(), save the current working directory and restore
# it when your script is done, as per the example code below.
#
# oldWD <- getwd()
# setwd("<your/project/directory>")
#
# setwd(oldWD)   # <--- move this to the end of your script

# ====  PARAMETERS  ============================================================
# Define and explain all parameters. No "magic numbers" in your code below.


             #
             #      This script uses guard-blocks that prevent execution of
             #      code that should not be executed when the entire script
             #      is sourced. Thus it can be source()'d to load its functions,
             #      or executed interactively.
             #
if (FALSE) { # <--- Keep this guard-block only if your script needs to be
             #      source()'d without side effects, since loading parameters
             #      changes the global workspace. If side-effects are oK
             #      remove this guard block, and the others in this script as
             #      required.




}



# ====  PACKAGES  ==============================================================
# Load all required packages.
#
# Use non-standard libraries with  package::function() idiom if possible.

if (! requireNamespace(seqinr, quietly=TRUE)) {
  install.packages("seqinr")
}
# Package information:
#  library(help = seqinr)       # basic information
#  browseVignettes("seqinr")    # available vignettes
#  data(package = "seqinr")     # available datasets




# ====  FUNCTIONS  =============================================================

# Define functions or source external files
if (FALSE) { # <---- If your script needs to be side-effect proof, source
             #       only scripts that are themselves side-effect proof or
             #       keep this guard block in place.

  source("<myUtilityFunctionsScript.R>")

}

myFunction <- function(a, b=1) {
	# Purpose:
	#     Describe ...
	# Parameters:
	#     a: ...
	#     b: ...
	# Value:
	#     result: ...

	# code ...

	return(result)
}



# ====  PROCESS  ===============================================================
# Enter the step-by-step process of your project here. Strive to write your
# code so that you can simply run this entire block and re-create all
# intermediate results.
if (FALSE) {

# ...



}

# ====  TESTS  =================================================================
if (FALSE) {
# Enter your function tests here...

}


# [END]
