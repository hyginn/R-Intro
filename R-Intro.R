# R-Intro.R
#
# Purpose: Introduction to R
#          - expressions
#          - functions
#          - data ...
#
# Version: 1.1
#
# Date:    2017  06  01
# Author:  Boris Steipe (boris.steipe@utoronto.ca)
#
# V 1.1    2017 updates
# V 1.0    First code 2016
#
# TODO:
#
#
# == HOW TO WORK WITH THIS FILE ================================================
#
#  Go through this script line by line to read and understand the
#  code. Execute code by typing <cmd><enter>. When nothing is
#  selected, that will execute the current line and move the cursor to
#  the next line. You can also select more than one line, e.g. to
#  execute a block of code, or less than one line, e.g. to execute
#  only the core of a nested expression.
#
#  Edit code, as required, experiment with options, or just play.
#  Especially play.
#
#  DO NOT simply source() this whole file!
#
#  If there are portions you don't understand, use R's help system,
#  Google for an answer, or ask me. Don't continue if you don't
#  understand what's going on. That's not how it works ...
#
#  Once you have typed and executed the function init(), you will find a file
#  called myScript.R in the project directory.
#
#  Open it, you can place all of your code-experiments and notes into that
#  file. This will be your "Lab Journal" for this session.
#
# ==============================================================================

#TOC> ==========================================================================
#TOC>
#TOC>   Section  Title                                            Line
#TOC> ----------------------------------------------------------------
#TOC>   1        Getting data into R                                96
#TOC>   1.1      Assigning variables                                99
#TOC>   1.2      Digression: Configuring startup behaviour ...     128
#TOC>   1.2.1    Task: a simple function; configuring R            153
#TOC>   1.3      DATA TYPES ...                                    175
#TOC>   1.3.1    Scalars                                           177
#TOC>   1.3.1.1  Task: Language keywords                           193
#TOC>   1.3.2    Vectors                                           221
#TOC>   1.4      A source of data ...                              242
#TOC>   1.4.1    Task: Getting data into R                         255
#TOC>   1.4.2    Task: Working with strings                        278
#TOC>   2        Storing data in R                                 299
#TOC>   2.1      Lists                                             303
#TOC>   2.2      Dataframes - from csv or tsv data                 332
#TOC>   2.2.1    Task: Read supplementary table S3 from Excel      412
#TOC>   2.2.2    Digression: Factors in dataframes                 439
#TOC>   2.2.3    Task: Fix problems of the "LPSdat" dataframe      500
#TOC>   2.3      First view of the S3 data                         511
#TOC>   2.3.1    Task: characteristic genes?                       591
#TOC>   3        Programming basics                                610
#TOC>   3.1      Conditionals                                      619
#TOC>   3.2      Loops                                             688
#TOC>   3.2.1    for loop                                          690
#TOC>   3.2.2    while loop                                        715
#TOC>   3.2.3    Digression: namespaces                            772
#TOC>   3.2.4    Task: vectorize a previously written function     794
#TOC>   3.3      Task: more analysis of data                       809
#TOC>   4        Basic Analysis                                    820
#TOC>   4.1      Subsetting data - Review of the principles        825
#TOC>   4.1.1    A sample dataset                                  834
#TOC>   4.1.2    Subsetting by index                               877
#TOC>   4.1.2.1  Negative indices                                  921
#TOC>   4.1.3    Subsetting by logical                             932
#TOC>   4.1.3.1  Filtering by string matching expressions          985
#TOC>   4.1.4    Subsetting by name                               1003
#TOC>   4.1.5    The "$" operator                                 1036
#TOC>   4.2      Subsetting data - tasks                          1057
#TOC>   4.2.1    Example - Heatmap of a subset                    1337
#TOC>   5        Outlook, and further practice                    1363
#TOC>   5.1      Task: more analyis to consolidate concepts       1383
#TOC>
#TOC> ==========================================================================




# ==============================================================================
# =    1  Getting data into R  =================================================
# ==============================================================================

# ==   1.1  Assigning variables  ===============================================

x <- "1"
x
phi <- 2 * pi
phi
x <- pi
x

# Question: how many significant digits does R process?
# How do you print them all?

# TASK: find out how to control the number of digits
#       printed in a print() expression.


# ==== CHECKPOINT =========================
# Place a green PostIt on the lid of your
# laptop when done, place a pink PostIt
# if this didn't work or if you have
# questions.
# =========================================



# sprintf() gives the most control
sprintf("%50.49f", pi)


# ==   1.2  Digression: Configuring startup behaviour ...  =====================


# Various functions exist to display the properties of R objects.
# Here is a function that combines them:

typeInfo <- function(x) {
    print(x, digits=22)
    cat("str:    ")
    str(x)
    cat("mode:   ", mode(x), "\n")
    cat("typeof: ", typeof(x), "\n")
    cat("class:  ", class(x), "\n")
    # if there are attributes, print them too
    if (! is.null(attributes(x))) {
        cat("attributes:\n")
        print(attributes(x))
    }
}

# That's a useful utility to have.
# Let's take it apart.
# Where do we save it so it becomes available whenever
# we start up R?

# ===  1.2.1  Task: a simple function; configuring R         ===

# TASK:
#    1. Place the function typeInfo() into a file named "typeInfo.R" based on
#    the file "functionTemplate.R".
#    2. Annotate and comment as required.
#    3. Configure your project to load typeInfo.R upon startup (how?).
#    4. Exit R Studio, and start it again.
#
#    How do you know the function is now available?



# ==== CHECKPOINT =========================
# Place a green PostIt on the lid of your
# laptop when done, place a pink PostIt
# if this didn't work or if you have
# questions.
# =========================================



# ==   1.3  DATA TYPES ...  ====================================================

# ===  1.3.1  Scalars                                        ===
#
# Single elements (scalars) are vectors of length 1

(x <- 5)    # numeric
length(x)
typeInfo(x)

(x <- 5L)    # integer
length(x)
typeInfo(x)

(x <- TRUE)  # logical
length(x)
typeInfo(x)

# ==== 1.3.1.1  Task: Language keywords

# TASK:
#    1. Special strings in R include the following. Do *not* put these into
#       quotation marks!
#          TRUE and FALSE   # Booleans.
#          NA               # Not Available
#          NULL             # An empty vector
#          Inf              # Infinite  ... try 1/0
#          -Inf             # negative infinity
#          NaN              # Not a number ... log(-1)
#
#        What are the *types* of these special keywords?
#
#     2. Try:  typeInfo(as.numeric(NA))
#              typeInfo(as.integer(NA))
#              typeInfo(as.character(NA))
#        What's happening? Why is this behavior useful?

# ==== CHECKPOINT =========================
# Place a green PostIt on the lid of your
# laptop when done, place a pink PostIt
# if this didn't work or if you have
# questions.
# =========================================



# ===  1.3.2  Vectors                                        ===
#
# The key rule about vectors is: all elements *must* have the same type!

# Recapitulate:
v <- c(1, 1, 2, 3, 5, 8)
v
v <- c(v, 13, 25)
v

1:3
seq_along(v)

seq(-0.5, 0.5, by = 0.1)
rep("Ha", 3)

genes <- c("Spic", "Cebpb", "Lyz2", "Sfpi1", "Nfkbiz")
# These are the names of some of the genes that are markers for
# monocytes...


# ==   1.4  A source of data ...  ==============================================


# TASK: Unzip and browse the Jaitin et al. paper.
#

# We will make it our goal to analyse supplementary data from this
# paper.


# Often the data we need can be copied and pasted from simple
# text files.

# ===  1.4.1  Task: Getting data into R                      ===

# TASK: open the text file for "Fig_3-CharacteristicGenes".
#       (the link is in the Wiki) in your browser. I have
#       prepared this file from the text in the actual
#       paper.
#       How do we get this data into a vector?

#       First think of a way to do this by hand.
#       Then, design a function that would
#       do this conveniently.

#       -> See sampleSolution-readText.R if needed.



# ==== CHECKPOINT =========================
# Place a green PostIt on the lid of your
# laptop when done, place a pink PostIt
# if this didn't work or if you have
# questions.
# =========================================

# ===  1.4.2  Task: Working with strings                     ===

# TASK: Consolidate working with text: convert a binomial
#       scientific name into a 5-letter label. The string
#       you work with should be something like
#       "arabidopsis thaliana". The result should be
#       "ARATH". Then make this into a function.

#       -> See sample solution if needed.


# ==== CHECKPOINT =========================
# Place a green PostIt on the lid of your
# laptop when done, place a pink PostIt
# if this didn't work or if you have
# questions.
# =========================================



# ==============================================================================
# =    2  Storing data in R  ===================================================
# ==============================================================================


# ==   2.1  Lists  =============================================================


# Lists are the workhorses of R. They are objects that
# can contain data of any type. Most of R's more advanced
# objects are lists "under the hood".

# A brief example:
pUC19 <- list(size = 2686,                              # number
              marker = "ampicillin",                    # character
              ori = "ColE1",
              accession = "L01397",
              inLab = TRUE,                             # Boolean
              sites = list(EcoRI=c(396),                # List
                           AclI=c(1924, 2297),
                           DraI=c(1563, 1582, 2274),
                           BanI=c(235, 408, 550, 1647)
              )
)
pUC19[[1]]
pUC19[[3]]
pUC19$ori
pUC19$sites
pUC19$sites$BanI
pUC19$sites$BanI[2]

unlist(pUC19)   # Explain ....


# ==   2.2  Dataframes - from csv or tsv data  =================================

# A data frame is a matrix or a "set" of data. It is
# a list of vectors and/or factors of the same length,
# that are related "across", such that data in the
# same position come from the same experimental unit
# (subject, animal, etc).

# Since it is basically a list, the columns can have different type!

# Your concept of a spreadsheet maps naturally into dataframes, where the
# rows are rows, and the columns are columns.

myDF <- data.frame(genes = c("Abc1", "Qrz", "Fubr31"),
                   expr = c(168059, 23490578, 34),
                   induced = c(TRUE, FALSE, FALSE))
myDF[-2,]
typeInfo(myDF)

# (We'll discuss factors below ...)


myDF <- data.frame(genes = c("Abc1", "Qrz", "Fubr31"),
                   expr = c(168059, 23490578, 34),
                   induced = c(TRUE, FALSE, FALSE),
                   stringsAsFactors = FALSE)
typeInfo(myDF)



# Why do we need data frames if they do the much
# the same as a list?
# More efficient storage, and indexing!
# R's read...() functions return data frames.

# ... which gets us back to our goal of studying details
# of the Jaitin et al. paper:

#     Are the "known" markers of Fig. 2 D enriched
#     as expected in the cell types?

# The relevant data is in supplementary table 3, which is an Excel spreadsheet.
# This is the same file that is posted with the paper as supplementary material
# on the Science Website.


# TASK: open supplementary table 3 in Excel:


# A word on Excel: it's a very good spreadsheet program,
# but it is miserable and often wrong on statistics,
# and it makes horrible, horrible plots.

# To elaborate - see the two links below:
# http://www.practicalstats.com/xlsstats/excelstats.html
# http://www.burns-stat.com/documents/tutorials/spreadsheet-addiction/
# ... these are not merely cosmetic problems!

# Therefore: It's oK to keep data in Excel spreadsheets
# if you must - but read it into R for any analysis!

# But be cautious: one of the problems of Excel is that
# it truncates numeric precision. Protip: convert all
# cells to "text" before export.

# There are many other "read" functions.
# Refer to the R Data Import / Export manual
# http://cran.r-project.org/doc/manuals/R-data.html
# See:
?read.table # ... includes read.csv and read.delim
?read.fwf   # ... for "fixed width format"
?readLines  # ... for reading in text-files line by line

# Excel spreadsheets should be converted to csv
# or tsv format. Alternatively the package
# xlsreadwrite is available via CRAN ... see
# http://cran.r-project.org/web/packages/xlsReadWrite/
# ... but I think this is unsound practice.


# ===  2.2.1  Task: Read supplementary table S3 from Excel   ===

# TASK:
# 1 - load the data in table_S3.xls
#     into Excel, and save it as
#     a .csv (comma separated values) file.
# 2 - Examine the file (a plain text file) in a
#     text-editor (such as the RStudio editor).
# 3 - Read the table into R, assigning it to a variable.
#     I usually give the first input of data the variable
#     name "rawDat" since it will usually be processed before
#     it becomes meaningful for analysis.
# 4 - Use head() to look at the beginning of the object.
# 5 - Remove any unneeded header rows.
# 6 - Give the columns names that reflect the cell type (cf.
#     Figure 2c), and the stimulus status.
# 7 - Use typeInfo() to analyse the object you have created.


# ==== CHECKPOINT  ... =====================


# Much output. Nb. for a heavy-duty function, we should rewrite
# typeInfo() to limit the output ...

# Now: what is it with the "factors".

# ===  2.2.2  Digression: Factors in dataframes              ===

# Many of R's dataframe methods convert all strings
# into factors by default. Factors are special types:
# they are nominally strings - (m, f) or (agree, neutral,
# disagree) or such. But underlyingly they are coded as integers
# that identify the "levels" of the factor.

# To illustrate.
genders <- factor(c("m", "f", "f", "m", "f"))
genders
typeInfo(genders)
is.ordered(genders)

# We can define ordered factors by adding some details to
# our factor() command - e.g. tumor grades:


sampleGrades <- factor(c("G1", "G3", "G3", "G1", "G2", "G1"),
                       levels = c("G1", "G2", "G3", "G4"),
                       ordered = TRUE)
sampleGrades   # Note that G4 is a level although it
# was not observed in the data
is.ordered(sampleGrades)

# Factors are useful since they support a number of analysis
# methods such as ordering boxplots, or calculating

# For more on factors, have a look at this factor tutorial
# by Jenny Bryan:
# http://www.stat.ubc.ca/~jenny/STAT545A/block08_bossYourFactors.html
# and this discussion on their use:
# http://stackoverflow.com/questions/3445316/factors-in-r-more-than-an-annoyance
#

# But for our purposes, the default behavior of R, to
# treat all strings as factors is entirely unwanted
# and needs to be turned off. Always use the parameter
# stringsAsFactors = FALSE to achieve this. If you don't
# you are in for some bad surprises if e.g. there is
# a character "contaminant" such as "NA" in a numeric column.

# Note: you can change R's default behaviour and set a global
#       option to "turn factors off". Some advocate this,
#       I don't think this is a good idea, since you may
#       encounter packages or functions that make
#       assumptions about R's default behaviour and will thus
#       fail.

myDF <- data.frame(data = c("N/A", 1, 1, 2, 3, 5, 8))
typeInfo(myDF)
myDF <- myDF[-1, ]
myDF

myDF2 <- as.numeric(myDF)
myDF2     # Whoa! what just happened ?

myDF3 <- as.numeric(as.character(myDF))
myDF3     # :-)


# ===  2.2.3  Task: Fix problems of the "LPSdat" dataframe   ===


# TASK: Repair the LPSdat data.frame - reload it with
#       stringsAsFactors = FALSE

#       -> See sample solution sampleSolution-readSup3.R if needed.

# ==== CHECKPOINT  ... =====================


# ==   2.3  First view of the S3 data  =========================================


# Check to see what we have ...

LPSdat[1:10,]
head(LPSdat)
tail(LPSdat)
nrow(LPSdat)
ncol(LPSdat)


LPSdat$genes[1:10]

# This is my preferred way of identifying columns in dataframes. It is more
# explicit (and therefore safer) than putting ...
LPSdat[1:10, 1]
# ... into a script, although it accomplishes the same.
#

# I will use this "$" syntax throughout - unless there is an important reason
# not to.

# Now we can finally return to our original question:
#     Are the "known" markers of Fig. 2 D enriched
#     as expected in the cell types?
#
# How do enrichment profiles characterize cell-types
# in the data? Try:

LPSdat[LPSdat$genes == "Cd19", ]
LPSdat[LPSdat$genes == "Cd8a", ]

# But!
LPSdat[LPSdat$genes == "B220", ]   # Not found!

# B220 has a number of synonyms as a quick Google search shows:
#       B220
#       CD45
#       CD45R
#       GP180
#       L-CA
#       LCA
#       LY5
#       PTPRC
#       T200

# We should check if the gene is listed under any of
# these synonyms in the data...

# Is there a convenient way to convert such lines into
# a character vector?

# Yes: as we have done above, define the list as one string constant, then use
# strsplit() on it.

s <- "B220
CD45
CD45R
GP180
L-CA
LCA
LY5
PTPRC
T200"
B220synonyms <- unlist(strsplit(s, "\n"))

# The way to check whether a string is contained
# in data is the _extremely_ useful %in% operator.

?"%in%"
B220synonyms %in% toupper(LPSdat$genes)

# However - no luck. None of the synonyms is in the table either.
# How do we know that this is not a problem with our expression?

# Positive control!
c(B220synonyms, "CD19") %in% toupper(LPSdat$genes)


# ===  2.3.1  Task: characteristic genes?                    ===


# TASK: check if our "characteristic genes" from Fig. 3B are all in the table
#       then find the enrichment vectors for the subset
#       Bst2, Siglech, Ly6d, Irf8

#       What do you find?

# ==== CHECKPOINT  ... =====================




# To do more than that, we really need to look at writing
# "programs".


# ==============================================================================
# =    3  Programming basics  ==================================================
# ==============================================================================


# We need two major concepts to program:
# - defining conditions (TRUE/FALSE)
# - repeating commands (loops, control flow)


# ==   3.1  Conditionals  ======================================================

x <- -2

if(x>0) {
    print(x)
} else if (x==0) {
    print(0)
} else {
    print(-x)
}

# Logical vectors
?TRUE

# Explore conditional statements
if (TRUE)   {print("true")} else {print("false")}
if ("true") {print("true")} else {print("false")}
if ("t")    {print("true")} else {print("false")}
if (1)      {print("true")} else {print("false")}
if (0)      {print("true")} else {print("false")}
if (-1)     {print("true")} else {print("false")}
if (pi)     {print("true")} else {print("false")}
if (Inf)    {print("true")} else {print("false")}
if (NULL)   {print("true")} else {print("false")}
if (NA)     {print("true")} else {print("false")}
if (NaN)    {print("true")} else {print("false")}
if (Inf)    {print("true")} else {print("false")}

# Logical operators
TRUE
! TRUE
FALSE > TRUE
FALSE < TRUE
FALSE < -1
0 == FALSE
"x" == "u"
"x" >= "u"
"x" <= "u"
"x" != "u"
TRUE | FALSE
TRUE & FALSE

# equality and identity
?identical
a <- TRUE
b <- TRUE
a; b
a == b
identical(a, b)

b <- 1
a; b
a == b
identical(a, b)

# some other useful tests for conditional expressions
?all
?any
?duplicated
?exists
?is.character
?is.factor
?is.integer
?is.null
?is.numeric
?is.unsorted
?is.vector

# ==   3.2  Loops  =============================================================

# ===  3.2.1  for loop                                       ===
n <- 1000000
x <- rnorm(n,10,1)
y <- sqrt(x)

# Vectors can grow as necessary ...
lim <- 50000 # try this with successively larger values
l <- c();
system.time(
    for (i in 1:lim) {
        l[i] <- sqrt(x[i])
    }
)

# ... at a great performance cost. Precreating them for the
# required length is much more efficient.
lim <- 50000 # try this with successively larger values
l <- numeric(lim)
system.time(
    for (i in 1:lim) {
        l[i] <- sqrt(x[i])
    }
)


# ===  3.2.2  while loop                                     ===
x <- ""
while (substr(x, nchar(x), nchar(x)) != "K") {
    x <- paste(x, sample(LETTERS[-c(2,10,15,21,24,26)], 1), sep="")
}
x

# What does this do?



# =============================================
# Efficiency of loops
# A big topic among R-tisans...

y <- numeric(length(x))
z <- y

system.time(for (i in 1:length(x)) {y[i] <- sqrt(x[i])})
system.time(z <- sqrt(x))
identical(y, z)

# The efficient vector code underneath R causes
# operations that can be vectorized to be about
# 100 times faster than if done in a loop.

# But what to do with matrices?
# Consider:

n <- 1000000
x <- rnorm(n,10,1)
x <- cbind(x, rnorm(n,10,1))
x <- cbind(x, rnorm(n,10,1))

y <- numeric(length(x))
system.time(
    for (i in 1:nrow(x)) {
        y[i] <- sqrt(sum(x[i,]))
    })

# R has a set of functions that take advantage
# of this: ?apply and its siblings:

z <- numeric(length(x))
system.time(z <- apply(x, 1, function(myRow) {sqrt(sum(myRow))}))
identical(y,z)

rm(x)
rm(y)
rm(z)


# Usually the time savings of apply() are considered important.
# I often prefer the explicitness of simple for-loops
# for development and debugging.


# ===  3.2.3  Digression: namespaces                         ===


# A note on namespaces
mf <- function(a){
    for (i in 1:a) {
        cat("Hello ")
    }
}
mf(3)

typeof(3)
typeof <- function(a) {     # Here we "inadvertently"
    for (i in 1:a) {        # overwrite an inbuilt
        cat("Hello ")		        # function name.
    }
}
typeof(3)

rm(typeof)
typeof(3)

# ===  3.2.4  Task: vectorize a previously written function  ===

# TASK: write a biCodes function that
#       operates on vectors.


#       -> See sample solution if needed.

# ==== CHECKPOINT  ... =====================



# .... Back to our dataset


# ==   3.3  Task: more analysis of data  =======================================


# TASK: what genes have the characteristics of the
#       unlabelled cluster in Figure 3B?
#       Develop the structure of a program to find them.
#       Implement it step by step.



# ==============================================================================
# =    4  Basic Analysis  ======================================================
# ==============================================================================



# ==   4.1  Subsetting data - Review of the principles  ========================


# A significant portion of your efforts in any project will be spent on
# preparing data for analysis. This includes reading data from various sources,
# preprocessing it, and extracting subsets of interest. R has powerful functions
# that support these tasks.


# ===  4.1.1  A sample dataset                               ===

# Let's start with a small datframe of synthetic data to go through the main
# principles of subsetting. The same principles apply to matrices and vectors -
# however, data frames are more flexible because their columns can contain data
# of different types (character, numeric, logical ...). Values in vectors and
# matrices must always have the same type.

# Imagine you are a naturalist who has collected some living things and keeps
# observations in a table ...

set.seed(112358)
N <- 10

dat <- data.frame(name = sample(LETTERS, N, replace = TRUE),
                  legs = sample(c(2 * (0:5), 100), N, replace = TRUE),
                  type = character(N),
                  matrix(rnorm(5 * N), ncol = 5),
                  stringsAsFactors=FALSE)

# Some auxiliary data ...
dict <- c("fish", "bird", "beast", "bug", "spider", "crab", "centipede")
names(dict) <- c(2 * (0:5), 100)
#... to populate the >>type<< column:
dat$type <- dict[as.character(dat$legs)]

# If you already understand the expression above, you're doing pretty well with
# the topic of this tutorial. If you don't, don't worry - by the end of the
# tutorial you will.

# Now let's see what we have:

head(dat)
str(dat)

# Note that we have given names to some columns, but R made names for the five
# columns of random values that were created as a matrix. Let us look at the
# basic ways to subset such objects. Basically, all these methods work with the
# subsetting operator "[".

?"["


# ===  4.1.2  Subsetting by index                            ===

# Elements can be uniquely identified by indices in the range of their length
# (for vectors), or their rows and columns (in dataframes and matrices). The
# order is row, column.

dat[2,3]   # one element
dat[2, ]   # empty columns: use all of them
dat[ , 3]  # empty rows, use all of them

# If you want a particular set of row and columns, pass a vector of positive
# integers.
dat[c(2, 3), c(1, 2, 3)]

# Any function that returns a vector of integers can be used. Most frequently we
# use the range operator ":" . Retrieving ranges of rows and/or columns from a
# matrix or data frame is also called "slicing".

dat[1:4, 1:3]
dat[4:1, 1:3]   # same in reverse order
dat[seq(2, N, by=2), ]   # even rows

# But we can do more interesting things, since the indices don't have to be
# unique, or in any order:

dat[c(1, 1, 1, 2, 2, 3), 1:3]

# In particular we can select random subsets...
dat[sample(1:N, 3), 1:3]
dat[sample(1:N, 3), 1:3]
dat[sample(1:N, 3), 1:3]

# ... or sort the dataframe. Sorting requires the order() function, not sort().

sort(dat[ , 2])    # ... gives us the sorted values

order(dat[ , 2])   # ... tells us in which row the sotrted values are
dat[order(dat[ , 2]), 1:3]  # ordered by number of legs
dat[order(dat[ , 1]), 1:3]  # ordered by lexical order of names

# Note: I am indenting expressions so you can first evaluate the expressions
# individually, then see how they fit into the brackets to subset the data.


# ==== 4.1.2.1  Negative indices

# If you specify a negative index, that element is excluded.

dat[-1, 1:3]   # not the first row
dat[-N, 1:3]   # not the last row

dat[-1:-3, 1:3]
dat[-(1:3), 1:3]  # same effect


# ===  4.1.3  Subsetting by logical                          ===


# Instead of indices, we can specify sets of rows or columns by boolean values
# (type: logical): TRUE or FALSE. If we place a vector of logicals into the
# square brackets, only the rows resp. columns for which the expression is TRUE
# are returned.

dat[1:3, c(TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE)]

# You need to take care that the number of elements exactly matches the number
# of rows or columns, otherwise "vector recycling" will apply and this is
# probably unintended. Thus explicitly specifying a boolean selection like above
# is not all that useful. However, many R functions are "vectorized" and
# applying a logical expression or function to an entire column gives a vector
# of TRUE and FALSE values of the same length. If we place this vector into the
# square brackets, only the rows resp. columns for which the expression is TRUE
# are returned.

dat[ , 2]
dat[ , 2] > 4          # See how this creates a vector
dat[dat[ , 2] > 4, 1:3]

# Expressions can be combined with the "&" (and) and the "|" (or) operators.

dat[ , 4] > 0
dat[ , 5] < 0
dat[ , 4] > 0 & dat[ , 5] < 0
dat[dat[ , 4] > 0 & dat[ , 5] < 0, ]

# In this context, the any() and all() functions may be useful. But take care -
# you can't simply apply them to a range of columns: that would apply the
# condition to all elements of a selection at once. You need to use the apply()
# function to first return a vector. apply()'s second argument switches between
# row-wise and column-wise evaluation. Here, 1 means operate on rows."

apply(dat[ , 4:8], 1, max)           # row-wise, fetch the maximum
apply(dat[ , 4:8], 1, max) > 1       # max() > 1 ?
dat[apply(dat[ , 4:8], 1, max) > 1, ]

# To use any() and all(), we define our own function."

myF <- function(x){any(x > 1.5)}
myF(dat[3, 4:8])

apply(dat[ , 4:8], 1, myF)
dat[apply(dat[ , 4:8], 1, myF), ]

# But we can also write the definition "in place"...
apply(dat[ , 4:8], 1, function(x){all(x < 0.5)})

dat[apply(dat[ , 4:8], 1, function(x){all(x < 0.5)}), ]

# ==== 4.1.3.1  Filtering by string matching expressions

# The function grep(), and the %in% operator can be used to subset via string
# matching:

grep("r", dat[ , 3])          # types that contain "r"
dat[grep("r", dat[ , 3]), 1:3]

grep("^c", dat[ , 3])         # types that begin with "c"
dat[grep("^c", dat[ , 3]), 1:3]


scary <- c("spider", "centipede")
dat[ , 3] %in% scary
dat[dat[ , 3] %in% scary, 1:3]



# ===  4.1.4  Subsetting by name                             ===

# If rownames and/or columnnames have been defined, we can use these for
# selection. If not defined, they default to the row/column numbers as character
# strings(!).

rownames(dat)  # the row numbers, but note that they are strings!
colnames(dat)  # the ones we have defined

# If we place a string or a vector of strings into the brackets, R matches the
# corresponding row/ column names:"

dat[1:5, "name"]
dat[1:5, c("name", "legs")]
dat[1:5, "eyes"]   # error, that name does not exist

# We can combine the techniques e.g. to flexibly select columns. Here we select
# the X1 to X5 columns:

colnames(dat)
grep("^X", colnames(dat))
colnames(dat)[grep("^X", colnames(dat))]
dat[1:3, colnames(dat)[grep("^X", colnames(dat))]]

# This is very useful when the exact position of columns may have changed during
# the analysis. Actually, rows and columns should really never be selected by
# number even though we have done so above. Such numbers are "magic numbers" and
# code that relies on such magic numbers is heard to read and very hard to
# maintain. It is always better to expose the logic with which your columns are
# selected and to make the selection explicit and robust. An exception may be
# when you need a slice of the data for testing purposes, but even then it may
# be preferrable to use the head() or tail() functions.

# ===  4.1.5  The "$" operator                               ===

# The "$" operator returns a single column as a vector. It is not strictly
# necessary - the column can just as well be named in quotation marks within the
# brackets - but I think it makes for more readable code.
#
dat[1:3, "legs"]
dat$legs[1:3]    # same result. This is the preferred version.
dat$"legs"[1:3]  # works, but isn't necessary
dat[1:3, legs]   # this returns an error - hopefully; but if for any
# reason the object DOES exist, you'll get an un-
# expected result. Know when to quote!


# Three more functions that I use all the time for data manipulation:
?which
?unique
?duplicated



# ==   4.2  Subsetting data - tasks  ===========================================

# After this introduction/review, it is your turn to put things into practice,
# and to practice subsetting / filtering:

# Here are tasks for you to code. My suggested answers are included ... you need
# to scroll down to see them. Obviously this is pointless unless you really try
# to solve this yourself."

# get rows 1:10 of the first two columns of LPSdat


#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
LPSdat[c(1,2,3,4,5,6,7,8,9,10), c(1,2)]  # Awkward solution
1:10    # use range operators instead
1:2

LPSdat[1:10, 1:2]


# output rows 1:10 of the first two columns in reverse order


#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
10:1
LPSdat[10:1, 1:2]

# rows 1:10 of the first two columns in reverse order,
# but not the third row of the result



#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
LPSdat[10:1, 1:2]             # as before
(LPSdat[10:1, 1:2])[-3, ]      # then exclude the third row


# rows 1:10 of the first two columns in random order
#     hint: use sample()


#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
sample(1:10)
LPSdat[sample(1:10), 1:2]

# rows 1:10 of the first two columns, ordered by
# the value in the second column, ascending
#     hint: use order()


#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
LPSdat[1:10,2]
order(LPSdat[1:10,2])
LPSdat[order(LPSdat[1:10,2]), 1:2]

# rows 1:10 of the column named Mo.LPS


#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
LPSdat[1:10, "Mo.LPS"]   # two possibilities
LPSdat$Mo.LPS[1:10]      # I prefer this one


# rows 1:10 of the columns named Mo.LPS and Mo.ctrl


#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
LPSdat[1:10, c("Mo.LPS", "Mo.ctrl")]              # this will do

# all genes with gene-names that are three characters long
# hint: use the function nchar()

#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
LPSdat$genes
nchar(LPSdat$genes)
nchar(LPSdat$genes) == 3
LPSdat$genes[nchar(LPSdat$genes) == 3]

# column 1:2 of all rows with gene-names that contain
# the string "Il" (i.e. an interleukin)


#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
# Try this first:
grep("Il", "IlInThisString")
grep("Il", "NoneInThisString")   # not


grep("Il", LPSdat$genes)
LPSdat[grep("Il", LPSdat$genes), 1:2]

# all genes for which B-cells are stimulated by LPS by
# more than 2 log units.


#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
LPSdat$B.LPS - LPSdat$B.ctrl
(LPSdat$B.LPS - LPSdat$B.ctrl) > 2
LPSdat[(LPSdat$B.LPS - LPSdat$B.ctrl) > 2, 1:3]


# ===  4.2.1  Example - Heatmap of a subset                  ===

# Finally, let's plot a heatmap of the data, first subtracting the .ctrl values
# from .LPS values, then picking every gene for which at least one value has a
# more than two-fold expression change."

diffMat <- matrix(numeric(nrow(LPSdat) * 7), ncol = 7)
for (i in 1:7) {
    diffMat[ , i] <- LPSdat[ , (2*i)+1] - LPSdat[ , (2*i)]
}
colnames(diffMat) <- c("B",
                       "MF",
                       "NK",
                       "Mo",
                       "pDC",
                       "DC1",
                       "DC2")
selection <- apply(diffMat, 1, function(x) {any(abs(x) > 2)})
boxplot(diffMat[seq(1, nrow(LPSdat), by = 3), ])
rgcol <- colorRampPalette(c("#FF0000", "#000000", "#00FF00"))
heatmap(diffMat[seq(1, nrow(LPSdat), by = 3), ], col = rgcol(256))

# Fine. But what does this mean?


# ==============================================================================
# =    5  Outlook, and further practice  =======================================
# ==============================================================================

# There are many more function for data preparation that this tutorial did not
# cover. You should know about the following functions:"

?subset   # ... better not used in programs however
?match
?aggregate
?transform
?sweep
?with     # ... and within()

# And you should know about the following packages:

# https://cran.r-project.org/web/packages/plyr/
# https://cran.r-project.org/web/packages/dplyr/
# https://cran.r-project.org/web/packages/magrittr/


# ==   5.1  Task: more analyis to consolidate concepts  ========================

# TASK: find the top 30 most differentially enriched
#       genes in the Mo cells. Hint: you will need to sort
#       results ... but sort() is not the function you need,
#       you need order().

#       Then find the same for Mf cells.

#       Then find the union of the two sets. Plot the
#       differential enrichment of one against the other.


# TASK: Plot boxplots for the different cell-types,
#       then plot the actual values of requested
#       genes.


# TASK: Show the differential expression as a
#       barplot.


# TASK: Barplots are bad. Improve the barplot according to
#       Weissgerber et al.'s ideas

# TASK: Data integration
# 1 - find all genes that look like a Monocyte
#     response to LPS stimulation.
# 2 - translate their gene symbols to Entrez
#     IDs using http://biodbnet.abcc.ncifcrf.gov/
# 3 - see whether they are co-expressed (i.e.
#     presumably coregulated) at http://coxpresdb.jp/


# [END]
