# Load Packages -----------------------------------------------------------

# Load the tidyverse package

library(tidyverse)

# Import Data -------------------------------------------------------------

# Download data from https://rfor.us/penguins
# Copy the data into the RStudio project
# Create a new R script file and add code to import your data

penguins <- read_csv("penguins.csv")

# select() ----------------------------------------------------------------

# Use select() to keep only the sex variable

penguins |> 
  select(sex)

# Use select() to keep the island and sex variables

penguins |> 
  select(island, sex)

# Use one of the select() helper functions to keep all variables that have the letter s in their names

penguins |> 
  select(contains("s"))

# Use one of the select() helper functions to keep all variables that start with the letter b

penguins |> 
  select(starts_with("b"))

# Use select() to keep the variables from island to the end

penguins |> 
  select(island:sex)

# Use the dropping syntax with - to keep the same variables as above (island to the end)

penguins |> 
  select(-species)

# Drop all variables from bill_length_mm to body_mass_g

penguins |> 
  select(-(bill_length_mm:body_mass_g))

# mutate() ----------------------------------------------------------------

# Use mutate() to create a variable called observation_station and set its value to "Palmer"

penguins |> 
  mutate(observation_station = "Palmer")

# 2. Create a new variable based on other variables:

penguins |> 
  mutate(body_mass_lbs = body_mass_g / 453.6)

# 3. Change an existing variable

penguins |>
  mutate(bill_length_mm = bill_length_mm + 1)

# filter() ----------------------------------------------------------------

# Use filter() to only keep female penguins

penguins |> 
  filter(sex == "female")

# Use filter() to only keep penguins NOT on Torgersen island

penguins |> 
  filter(island != "Torgersen")

# Use filter() to only keep penguins on Torgersen island or Biscoe island
# Use the or logical operator (|) to do this

penguins |> 
  filter(island == "Torgersen" | island == "Biscoe")

# Rewrite your filter() code above to keep the penguins from Torgersen island or Biscoe island
# This time, though, use the %in% operator

penguins |> 
  filter(island %in% c("Torgersen", "Biscoe"))

# Use a comparison operator to keep penguins with flipper lengths greater than or equal to 193 millimeters

penguins |> 
  filter(flipper_length_mm >= 193)

# Drop any rows that have missing data in the flipper_length_mm variable

# Do this first with !is.na()

penguins |> 
  filter(!is.na(flipper_length_mm))

# Do this a second time with drop_na()

penguins |> 
  drop_na(flipper_length_mm)

# summarize() -------------------------------------------------------------

# Calculate the weight of the heaviest penguin.
# Don't forget to drop NAs!

penguins |> 
  summarize(max_body_mass = max(body_mass_g, na.rm = TRUE))

# Calculate the minimum and maximum weight of penguins in the dataset.

penguins |> 
  summarize(max_body_mass = max(body_mass_g, na.rm = TRUE),
            min_body_mass = min(body_mass_g, na.rm = TRUE))

# group_by() and summarize() ----------------------------------------------

# Calculate the weight of the heaviest penguin on each island.

penguins |> 
  group_by(island) |> 
  summarize(max_body_mass = max(body_mass_g, na.rm = TRUE))

# Calculate the weight of the heaviest penguin on each island for each year.

penguins |> 
  group_by(island, year) |> 
  summarize(max_body_mass = max(body_mass_g, na.rm = TRUE))

# arrange() ---------------------------------------------------------------

# Use arrange() to display the penguins data frame in order by body mass

penguins %>% 
  arrange(body_mass_g)

# Now display the penguins data in descending order by body mass

penguins %>% 
  arrange(desc(body_mass_g))

# Create a pipeline that does the following:
# 1. Filters to only keep penguins on Biscoe island
# 2. Drops any rows with NA values for the body_mass_g or sex variables
# 3. Calculates the average body mass by sex
# 4. Displays the result in descending order by average body mass

penguins |> 
  filter(island == "Biscoe") |> 
  drop_na(body_mass_g, sex) |> 
  group_by(sex) |> 
  summarize(avg_body_mass = mean(body_mass_g)) |> 
  arrange(desc(avg_body_mass))
