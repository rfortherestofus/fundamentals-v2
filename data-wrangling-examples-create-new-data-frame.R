# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv")

# Create a New Data Frame -------------------------------------------------

# Running pipelines simply displays the result

penguins |> 
  group_by(island, year) |> 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE)) |> 
  arrange(mean_bill_length)

# If we want to save the result, we need to use the assignment operator

# Most people use the left-hand assignment operator as follows:

penguin_weight_by_island <- penguins |> 
  group_by(island, year) |> 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE)) |> 
  arrange(mean_bill_length)

# You can also use the right-hand assignment operator as follows:

penguins |> 
  group_by(island, year) |> 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE)) |> 
  arrange(mean_bill_length) -> penguin_weight_by_island_v2



