#' loads the basic packages
library(here)
library(psych)
library(janitor)
library(tidyverse)

#' installs the "haven" package, if it is not already installed
install.packages("haven")
#' loads the "haven" package, which includes the function "read_sav" to allow the dataset file to be loaded into R
library(haven)

#' loads the dataset of healthcare workers (hcw) into R, and saves the data to a file called "hcw_data"
hcw_data <- read_sav("ICHCWIPC-5340-E-2020_F1.sav")

#' initial data inspection to ensure file is correctly loaded into R
str(test)

#' cleaning data
hcw_data_final <- hcw_data |>
  #' changes variable names to lowercase and underscore
  janitor::clean_names() |>
  #'
  mutate(gdrdvgrp = factor(gdrdvgrp, levels = 1:2, labels = c("Male",
                                                               "Female")),
         
         agedvg4 = factor(agedvg4, levels = 1:4, labels = c("Less than 35 years",
                                                             "35 to 44 years",
                                                             "45 to 54 years",
                                                             "55 years and older")),
         
         gen_15 = factor(gen_15, levels = 1:5, labels = c("Much better now",
                                                           "Somewhat better now",
                                                           "About the same",
                                                           "Somewhat worse now",
                                                           "Much worse now"))) |>
  #' removes participants with missing data
  filter(!is.na(gdrdvgrp)) |>
  filter(!is.na(agedvg4)) |>
  filter(!is.na(gen_15)) |>
  #' selecting the relevant variables
  select(gdrdvgrp, agedvg4, gen_15)

#' run descriptive statistics
summary(hcw_data_final)
