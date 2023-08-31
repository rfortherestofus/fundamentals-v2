# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv")

# arrange() ---------------------------------------------------------------

# With arrange(), we can reorder rows in a data frame based on the values 
# of one or more variables. 
# R arranges in ascending order by default.

penguins |> 
  arrange(bill_length_mm)

# We can also arrange in descending order using desc().

penguins |>  
  arrange(desc(bill_length_mm))

# We often use arrange() at the end of pipelines to display things in order.

penguins |> 
  group_by(island, year) |> 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE)) |> 
  arrange(desc(mean_bill_length))
