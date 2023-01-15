
library(tidyverse)

source("scripts/ingest.R")

data <- ingest()

data %>% ggplot() + geom_freqpoly(x = "Week Ending (Friday)", 