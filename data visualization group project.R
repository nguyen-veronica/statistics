#' loads the basic packages
library(ggplot2)
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
str(hcw_data)



#' cleaning data
hcw_data_final <- hcw_data |>
  
  #' changes variable names to lowercase and underscore
  janitor::clean_names() |>
  
  #' converts the relevant variables to factor type, and turns numerical data into comprehensible data
  mutate(gdrdvgrp = factor(gdrdvgrp, levels = 1:2, labels = c("Male",
                                                               "Female")),
         
         agedvg4 = factor(agedvg4, levels = 1:4, labels = c("<35",
                                                             "35-44",
                                                             "45-54",
                                                             "55 & over")),
         
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



#' graphing the plot
ggplot(hcw_data_final, aes(x = agedvg4, fill = gen_15)) +
  
  # turns the plot into a stacked bar chart
  geom_bar(position = "stack") +
  
  #' divides the data into two graphs according to age
  facet_wrap(~gdrdvgrp) +
  
  #' change titles and labels
  labs(title = "Perceived Mental Health by Age and Gender",
       x = "Age (Years)",
       y = "",
       fill = "Mental health compared to pre-pandemic")
