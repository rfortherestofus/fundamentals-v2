# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv")

# select() ----------------------------------------------------------------

penguins

# With select() we can select variables from the larger data frame.

penguins |> 
  select(bill_length_mm)

# We can also use select() for multiple variables:

penguins |>
  select(bill_length_mm, bill_depth_mm)

# select() has several helper functions for selecting variables.

# The contains() function finds any variable with certain text 
# in the variable name:

penguins |>
  select(contains("bill"))

# The starts_with() function allows us to select variables 
# that start with certain text:

penguins |> 
  select(starts_with("bill"))

# The ends_with() function allows us to select variables that end with certain text:

penguins |> 
  select(ends_with("mm"))

# We can select a range of columns using the var1:var2 pattern

penguins |> 
  select(species:bill_length_mm)

# We can drop variables using the -var format:

penguins |> 
  select(-bill_length_mm)

# We can drop a set of variables using the -(var1:var2) format:

penguins |> 
  select(-(bill_length_mm:flipper_length_mm))
