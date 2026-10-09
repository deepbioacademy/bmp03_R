# Intro to R
# Creating variables
a <- 10

# Evaluating Variables
a
print(a)

# Variable naming convention
age <- 10
gene_expression <- 30

# Functions
sum(11, 12, 13)
mean(20, 30, 55)

# Getting Help
help(mean)
?sd

# Install and load packages
install.packages("tidyverse")
library(tidyverse)

# Install Bioconductor
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.23")

# Advanced Package Handling
# Link: https://pak.r-lib.org/
install.packages("pak")

# Install Packages using pak (best practices)
pak::pkg_install("DESeq2")
pak::pkg_install("tidyplots")

# Collection of packages
pak::pkg_install(c("DESeq2", "tidyplots", "tidyverse"))
