# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv")

# filter() ----------------------------------------------------------------

# We use filter() to choose a subset of observations.

# We use == to select all observations that meet the criteria.

penguins |> 
  filter(species == "Adelie")

# We use != to select all observations that don't meet the criteria.

penguins |> 
  filter(species != "Adelie")

# We can combine comparisons and logical operators.

penguins |> 
  filter(species == "Adelie" | species == "Chinstrap")

# We can use %in% to collapse multiple comparisons into one.

penguins |> 
  filter(species %in% c("Adelie", "Chinstrap"))

# We can chain together multiple filter functions. 
# Doing it this way, we don't have create complex logic in one line.

# Complicated version

penguins |> 
  filter(species %in% c("Adelie", "Chinstrap") & island == "Torgersen")

# Simpler version

penguins |> 
  filter(species %in% c("Adelie", "Chinstrap")) |> 
  filter(island == "Torgersen")

# We can use <, >, <=, and => for numeric data.

penguins |> 
  filter(body_mass_g > 4000)

# We can drop NAs with !is.na(). 

penguins |> 
  filter(!is.na(sex))

# But the double negative is confusing.
# We can also drop NAs with drop_na().

penguins |> 
  drop_na(sex)