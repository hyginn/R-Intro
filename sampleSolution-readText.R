# readText.R
#
# Purpose:  Read contents of a small text-file into R
#
# ==============================================================================

# ==== A: Enter data one by one ============
#
# 1. use a text-processor to replace each occurrence of a
#    paragraph-break with the string ", ".
# 2. wrap the string with c() and assign it.

charGenes <- c("Cd19", "Cd79b", "Cd22", "Cd37", "Ctsd",
               "Apoe", "C1qa", "C1qb", "C1qc", "Csf1r",
               "Slpi", "Tlr2", "Mmp13", "Marco", "Ifng",
               "Gzmb", "Myc", "Xcl1", "Ccl5", "Gzma",
               "Nkg7", "Spic", "Cebpb", "Lyz2", "Sfpi1",
               "Nfkbiz", "Bst2", "Siglech", "Ly6d", "Irf8",
               "Cst3", "Naaa", "Ccr7", "Cxcl9", "Traf1",
               "Relb", "Itgax", "Tmem176b", "Tnf", "Tnfaip3",
               "Nfkbia", "Il15", "Cxcl10", "Ifit1", "Isg15",
               "Irf7")



# ==== B: Enter data "by hand" all at once =

# 1. Copy/paste the contents of Fig_3-CharacteristicGenes.txt
# 2. Place all into quotation marks
# 3. Assign this multi-line string a variable
# 4. Use strsplit() to split it into elements
# 5. unlist() the result
# 6. assign the result


s <- "Cd19
Cd79b
Cd22
Cd37
Ctsd
Apoe
C1qa
C1qb
C1qc
Csf1r
Slpi
Tlr2
Mmp13
Marco
Ifng
Gzmb
Myc
Xcl1
Ccl5
Gzma
Nkg7
Spic
Cebpb
Lyz2
Sfpi1
Nfkbiz
Bst2
Siglech
Ly6d
Irf8
Cst3
Naaa
Ccr7
Cxcl9
Traf1
Relb
Itgax
Tmem176b
Tnf
Tnfaip3
Nfkbia
Il15
Cxcl10
Ifit1
Isg15
Irf7"

charGenes <- unlist(strsplit(s, "\n"))



# ==== C: Use readLines() =============
charGenes <- readLines("Fig_3-CharacteristicGenes.txt")

# Note: this produces a vector of strings



# ==== D: Use read.csv() =============
charGenes <- read.csv("Fig_3-CharacteristicGenes.txt",
                      header = FALSE,
                      stringsAsFactors = FALSE)

# Note: this produces a dataframe



# [END]
