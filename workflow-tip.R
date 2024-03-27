# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv") |> 
  filter(year == 2007)

# Data Viz ----------------------------------------------------------------

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,
                     y = bill_depth_mm)) +
  geom_point()
