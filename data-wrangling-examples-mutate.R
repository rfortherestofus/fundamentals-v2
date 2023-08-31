# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv")

# mutate() ----------------------------------------------------------------

# We use mutate() we make new variables or change existing ones. 

# We can use mutate() in three ways. 

# 1. Create a new variable with a specific value:

penguins |> 
  mutate(continent = "Antarctica")

# 2. Create a new variable based on other variables:

penguins |> 
  mutate(body_mass_lbs = body_mass_g / 453.6)

# 3. Change an existing variable

penguins |>
  mutate(bill_length_mm = bill_length_mm + 1)
