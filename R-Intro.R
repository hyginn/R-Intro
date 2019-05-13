# R-Intro.R
#
# Purpose: Introduction to R workshop
#          - workshop setup
#          - contents and reference to workshop modules
#          - contents of supporting modules and assets
#
# Version: 2.1
#
# Date:    2019  05  012
# Author:  Boris Steipe (boris.steipe@utoronto.ca)
#
# V 2.1    2019 updates
# V 2.0    Reconceived for 2018 workshop
# V 1.1    2017 updates
# V 1.0    First code 2016
#
# TODO:
#
# ==============================================================================


#TOC> ==========================================================================
#TOC> 
#TOC>   Section  Title                             Line
#TOC> -------------------------------------------------
#TOC>   1        INTRODUCTION                        39
#TOC>   2        GETTING STARTED                    104
#TOC>   2.1        Keep a Journal ...               107
#TOC>   2.2        What's in the box ...            142
#TOC>   3        SIMPLE SEQUENCE ANALYSIS           177
#TOC>   4        DATA INTEGRATION                   185
#TOC>   5        NUMERIC DATA                       191
#TOC>   6        FOOTNOTES                          198
#TOC> 
#TOC> ==========================================================================


# =    1  INTRODUCTION  ========================================================

# You have worked through the pre-class introductory tutorial linked from
# http://steipe.biochemistry.utoronto.ca/abc/index.php/R_tutorial (and if you
# haven't - let us know!). This is a classical way of introducing material in a
# structured, piecewise, linear fashion, concept by concept. In our class-time
# we will do something different: we'll work on four mini-projects that
# integrate the pre-work concepts. In this way, we'll cover all the basics,
# introduce some new ideas, but most importantly, practice using R in real-world
# scenarios.

# It's easy to hack together a few lines of code - that's something you can
# always do. But we'll take the opportunity in this workshop to practice some
# sound principles of development: specifying tasks, breaking workflow up
# into functions, organizing a project directory, writing tests, working
# with scripts to keep things reproducible, and more.

# We will proceed by defining tasks, then it is up to you to break down the
# task into small, computable steps, and to implement them. As we go along,
# we'll also learn to validate and debug code.

# Usually the tasks will involve steps that you don't know how to do. That's
# exactly what will happen in real life: in a research context we don't stop
# after we solve a problem. Any solution is only a starting point for the next
# question to which you don't know the answer. Being in a state of "knowing
# nothing" is not an exception, it's our daily life. Therefore the focus of the
# workshop is not (only) to provide answers, because "answers" I can give you
# will be (mostly) irrelevant for the tasks you work on at home. Rather we will
# focus on problem-solving strategies: precisely defining questions and
# constructing solutions, systematically, step by step. "Community intelligence"
# will be our key to progress, and - as experience shows - the solutions we come
# up with as a team are going to be much smarter than what I could come up with
# by myself. But note: what you take home from here is not going to be in a
# folder of handouts that collect dust in your office, it's going to be in the
# notes you take, the scripts you write, and the attitudes and habits you adopt
# (1).

# Our three projects focus on:
#   - simple sequence analysis
#   - data integration
#   - working with numeric data

# The tasks are contained in R scripts. Basically all learning in this workshop
# involves working from a script, executing code and experimenting with it.
# That makes it simple for you to save your notes and comments together
# with your work, where they belong.

# But there's a catch: sometimes we update scripts during the course or
# workshop. Now: all of the material is in an R project that is loaded from
# GitHub, so updating files with our edits is easy - just select "Pull branches"
# from the version control menu. However, that would overwrite your local
# changes - your notes and comments. So we made "personal" copies of all the
# scripts and other assets. When you excuted the "init()" function, this created
# copies of the scripts, that you can work with and edit safely.

# Script file:            |  Copy that you open and edit:
# ------------------------+-------------------------------
# journal.md              |  myJournal.md
# sequenceAnalysis.R      |  mySequenceAnalysis.R
# dataIntegration.R       |  myDataIntegration.R
# numericData.R           |  myNumericData.R

# Once again: edit, annotate, extend and work with my<file>.R files. Save these
# files and refer to them.

# =    2  GETTING STARTED  =====================================================


# ==   2.1  Keep a Journal ...  ================================================

# To profit the most from this workshop, it is imperative that you take notes,
# lots of notes. Code examples and task annotations go directly into the
# my<file>.R files but concepts are much better paraphrased and hand-written in
# your journal: you'll find that this dramatically improves your focus and
# understanding.

# There are many ways to keep a journal:
#  - handwritten notes are excellent because manual note-taking enhances
#    engagement and memory.
#  - Text-files can be edited within RStudio; but in a text file you won't get
#    syntax highlighting, and you wont get clickable links.
#  - R scripts are great for code, but not so great for documentation. Also
#    you won't get hyperlinks.
#  - A great compromise is a markdown file. That's what we'll use in this
#    workshop. More details below.
#  - In my University courses, my students use MediaWiki. I find this to be the
#    tool with the widest range of advantages: text, formatting, images and
#    tables are trivial, hyperlinking to local and non-local documents too,
#    document management works, collaborative editing is easy, search functions
#    find things within and accross documents, and you get a full page-history
#    and attribution. The only downside is that you have to maintain your
#    own Wiki installation.

# TASK:
#   Open the file myJournal.md for editing. Study the code example inside out
#   by selecting and executing code.

# TASK:
#   Copy and paste the directory tree into your journal. Add comments what
#   these files are.



# ==   2.2  What's in the box ...  =============================================

# Overview of files and assets:
#
# --R-Intro/
#     |__.gitignore
#     |__.init.R
#     |__.Rprofile
#     |__assets/
#         |__markdownCheatsheet.md
#         |__R_refcard_DataMining.pdf
#         |__R_refcard.pdf
#     |__data/
#         |__[...]
#     |__dataIntegration.R
#     |__dev/
#         |__addTOC.R
#         |__grepSrc.R
#         |__rptTwee.R
#     |__functionTemplate.R
#     |__journal.md
#     |__myDataIntegration.R
#     |__myJournal.md
#     |__myNumericData.R
#     |__mySequenceAnalysis.R
#     |__numericData.R
#     |__R/
#         |__biCode.R
#         |__readFASTA.R
#     |__README.md
#     |__sampleSolutions/
#         |__[...]
#     |__scriptTemplate.R
#     |__sequenceAnalysis.R

# =    3  SIMPLE SEQUENCE ANALYSIS  ============================================

# In the file pane of RStudio, click on "mySequenceAnalysis.R" to work with- and
# edit it. (What? There is no file by that name? Either you never typed init(),
# or you are not looking at the right directory. If you can't figure out what
# the problem is, let us know.)


# =    4  DATA INTEGRATION  ====================================================

# Next, open "myDataIntegration.R" to enter your code as we work through the
# scenario and tasks.


# =    5  NUMERIC DATA  ========================================================

# In this unit we will perform numeric calculations - with 3D protein
# strucure data. Open "myNumericData.R" for your notes and code experiments.



# =    6  FOOTNOTES  ===========================================================

# (1) I am reminded of a student complaint: "I didn't like this lecturer. She
#     made us learn everything by ourselves."

# [END]
