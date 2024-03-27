# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv")

penguins_by_species <- penguins |> 
  count(species)

# Setting color and fill Scales -------------------------------------------

# Take your scatterplot that you just made and add a scale using scale_color_manual(). 
# You can find a list of all colors you can use here:
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     color = island)) +
  geom_point() +
  scale_color_manual(values = c("red", "blue", "green"))

# Now update the last bar chart you made by manually specifying colors of the bars

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n,
                     fill = species)) +
  geom_col() +
  scale_fill_manual(values = c("red", "blue", "green"))

# Update your bar chart using the scale_fill_viridis_d() function instead of
# scale_fill_manual()

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n,
                     fill = species)) +
  geom_col() +
  scale_fill_viridis_d()

# Make a custom palette

nc_rural_red <- "#e56c01"
nc_rural_yellow <- "#ffcd00"
nc_rural_green <- "#26a848"

scale_fill_nc_rural <- function() {
  scale_fill_manual(
    values = c(nc_rural_red, 
               nc_rural_yellow,
               nc_rural_green)
  )
}

scale_color_nc_rural <- function() {
  scale_color_manual(
    values = c(nc_rural_red, 
               nc_rural_yellow,
               nc_rural_green)
  )
}

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n,
                     fill = species)) +
  geom_col() +
  scale_fill_nc_rural()

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     color = island)) +
  geom_point() +
  scale_color_nc_rural()
