# data from https://www.health.gov.au/resources/publications/national-notifiable-diseases-surveillance-system-nndss-public-dataset-influenza-laboratory-confirmed?language=en

library(readxl)
library(tidyverse)

ingest <- function() {
  data_file_loc <- "data/national-notifiable-diseases-surveillance-system-nndss-public-dataset-influenza-laboratory-confirmed-dataset.xlsx"

  # file.exists(data_file_loc)
  
  # data is over multiple tabs (time periods)
  # data is right-cornered at cell 6,5
  
  data_range <- cell_limits(c(5,NA),c(NA,6))

  sheet1 <- read_excel(data_file_loc, range = data_range, sheet = 1)
  sheet2 <- read_excel(data_file_loc, range = data_range, sheet = 2)
  sheet3 <- read_excel(data_file_loc, range = data_range, sheet = 3)
  
  bind_rows(sheet1,sheet2,sheet3) %>% 
    rename(Week = `Week Ending (Friday)`) %>% 
    rename(Age = `Age  group`) %>% 
    rename(Indigenous = `Indigenous status`) %>% 
    rename(Type = `Type/Subtype`) %>% 
    as_tibble()
}







