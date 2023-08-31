# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv")

# summarize() -------------------------------------------------------------

# With summarize(), we can go from a complete dataset down to a summary.

# We use any of the summary functions with summarize().
# Here's how we calculate the mean bill length.

penguins |> 
  summarize(mean_bill_length = mean(bill_length_mm))

# This doesn't work! Notice what the result is. 

# We need to add na.rm = TRUE to tell R to drop NA values.

penguins |> 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

# Another option is to drop NA values before calling summarize().

penguins |> 
  drop_na(bill_length_mm) |> 
  summarize(mean_bill_length = mean(bill_length_mm))

# We can have multiple arguments in each usage of summarize().

penguins |> 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_depth = max(bill_depth_mm, na.rm = TRUE))

penguins |> 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE)) |> 
  summarize(mean_bill_depth = mean(bill_depth_mm, na.rm = TRUE)) 
