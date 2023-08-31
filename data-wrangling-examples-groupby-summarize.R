# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv")

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
