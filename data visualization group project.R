#' loads the basic packages
library(here)
library(psych)
library(tidyverse)

#' installs the "haven" package, if it is not already installed
install.packages("haven")
#' loads the "haven" package, which includes the function "read_sav" to allow the dataset file to be loaded into R
library(haven)

#' loads the dataset of healthcare workers (hcw) into R, and saves the data to a file called "hcw_data"
hcw_data <- read_sav("ICHCWIPC-5340-E-2020_F1.sav")

#' initial data inspection to ensure file is correctly loaded into R
str(test)
