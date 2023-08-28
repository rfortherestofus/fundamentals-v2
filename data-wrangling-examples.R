
# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv")

# select() ----------------------------------------------------------------

# With select() we can select variables from the larger data frame.

penguins |> 
  select(bill_length_mm)

# We can also use select() for multiple variables:

penguins %>%
  select(bill_length_mm, bill_depth_mm)

# select() has several helper functions for selecting variables.

# The contains() function finds any variable with certain text in the variable name:

penguins %>%
  select(contains("bill"))

# The starts_with() function allows us to select variables that start with certain text:

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
  select(bill_length_mm)

# We can drop a set of variables using the -(var1:var2) format:

penguins |> 
  select(-(bill_length_mm:flipper_length_mm))

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
            mean_bill_depth = mean(bill_depth_mm, na.rm = TRUE))

# group_by() and summarize() ----------------------------------------------

# summarize() becomes truly powerful when paired with group_by(), 
# which enables us to perform calculations on multiple groups. 

# Calculate the mean bill length for penguins on different islands.

penguins |> 
  group_by(island) |> 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

# We can use group_by() with multiple groups.

penguins |> 
  group_by(island, year) |> 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

# Another option is to use the .by argument in summarize().

penguins |> 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            .by = c(island, year))

# You can count the number of penguins in each group using the n() summary function.

penguins |> 
  group_by(island) |> 
  summarize(number_of_penguins = n())

# But a simpler way do this is with the count() function.

penguins |> 
  count(island)

# You can also use count() with multiple groups.

penguins |> 
  count(island, year)

# arrange() ---------------------------------------------------------------

# With arrange(), we can reorder rows in a data frame based on the values of one or more variables. 
# R arranges in ascending order by default.

penguins %>% 
  arrange(bill_length_mm)

# We can also arrange in descending order using desc().

penguins %>% 
  arrange(desc(bill_length_mm))

# We often use arrange() at the end of pipelines to display things in order.

penguins |> 
  group_by(island) |> 
  summarize(number_of_penguins = n()) |> 
  arrange(number_of_penguins)

# Create a New Data Frame -------------------------------------------------

# Running pipelines simply displays the result
# If we want to save the result, we need to use the assignment operator

# Most people use the left-hand assignment operator as follows:

penguins_by_island_v1 <- penguins |> 
  group_by(island) |> 
  summarize(number_of_penguins = n()) |> 
  arrange(number_of_penguins)

# You can also use the right-hand assignment operator as follows:

penguins |> 
  group_by(island) |> 
  summarize(number_of_penguins = n()) |> 
  arrange(number_of_penguins) -> penguins_by_island_v2



