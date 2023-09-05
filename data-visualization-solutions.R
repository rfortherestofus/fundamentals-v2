# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv")

# Scatterplots ------------------------------------------------------------

# Make a scatterplot that shows flipper length on the x axis and body mass on the y axis.

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g)) +
  geom_point()


# Histograms --------------------------------------------------------------

# Make a histogram that shows the distribution of the body_mass_g variable.

ggplot(data = penguins,
       mapping = aes(x = body_mass_g)) +
  geom_histogram()

# Adjust your histogram so it has 50 bins.

ggplot(data = penguins,
       mapping = aes(x = body_mass_g)) +
  geom_histogram(bins = 50)


# Bar Charts --------------------------------------------------------------

# Use the v1 approach to make a bar chart that shows a count of the number of penguins by species. 

ggplot(data = penguins,
       mapping = aes(x = species)) +
  geom_bar()

# Use the v2 approach by doing the following:
# 1. Creating a new data frame called penguins_by_year that is a 
# count of the number of penguins by species
# 2. Plot your data frame using the v2 approach with geom_bar()

penguins_by_species <- penguins |> 
  count(species)

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n)) +
  geom_bar(stat = "identity")

# Make the same graph as above, but use geom_col() instead of geom_bar()

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n)) +
  geom_col()

# Setting color and fill Aesthetic Properties -----------------------------

# Take your graph that uses geom_col() and make the inside of each bar a different color.

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n,
                     fill = species)) +
  geom_col()

# Make your scatterplot from before with flipper length on the x axis and body mass on the y axis
# but make the points different colors based on the island variable

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = body_mass_g,
                     color = island)) +
  geom_point()

# Setting color and fill scales -------------------------------------------

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

# Setting x and y Scales --------------------------------------------------

# Copy the code for the last bar chart you made
# Update it so that the y axis goes from 0 to 200

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n,
                     fill = species)) +
  geom_col() +
  scale_fill_viridis_d() +
  scale_y_continuous(limits = c(0, 160))

# Copy the code you just wrote
# Update it so that it has breaks on the y axis at 0, 40, 80, 120, and 160

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n,
                     fill = species)) +
  geom_col() +
  scale_fill_viridis_d() +
  scale_y_continuous(limits = c(0, 160),
                     breaks = c(0, 40, 80, 120, 160))

# Text and Labels ---------------------------------------------------------

# Copy your last code chunk. 
# Then add text labels on the top of each bar that show the number of penguins of each species.
# You'll need to use geom_text() and the vjust argument to do this.
# Make the text labels show up in red.

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n,
                     fill = species,
                     label = n)) +
  geom_col() +
  geom_text(vjust = -0.5,
            color = "red") +
  scale_fill_viridis_d() +
  scale_y_continuous(limits = c(0, 160),
                     breaks = c(0, 40, 80, 120, 160))

# Do the same thing, but use geom_label() instead of geom_text().
# This time, make the text itself show up in white.

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n,
                     fill = species,
                     label = n)) +
  geom_col() +
  geom_label(vjust = -0.5,
            color = "white") +
  scale_fill_viridis_d() +
  scale_y_continuous(limits = c(0, 160),
                     breaks = c(0, 40, 80, 120, 160))

# Plot Labels -------------------------------------------------------------

# Copy the code for the last plot you made that uses geom_label().
# Then do the following:
# 1. Add a title
# 2. Remove the x and y axis labels

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n,
                     fill = species,
                     label = n)) +
  geom_col() +
  geom_label(vjust = -0.5,
             color = "white") +
  scale_fill_viridis_d() +
  scale_y_continuous(limits = c(0, 160),
                     breaks = c(0, 40, 80, 120, 160)) +
  labs(title = "Number of penguins by species",
       x = NULL,
       y = NULL)

# Themes ------------------------------------------------------------------

# Use one of the built-in ggplot2 themes to change the look and feel of your last plot
# https://ggplot2.tidyverse.org/reference/index.html#themes

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n,
                     fill = species,
                     label = n)) +
  geom_col() +
  geom_label(vjust = -0.5,
             color = "white") +
  scale_fill_viridis_d() +
  scale_y_continuous(limits = c(0, 160),
                     breaks = c(0, 40, 80, 120, 160)) +
  labs(title = "Number of penguins by species",
       x = NULL,
       y = NULL) +
  theme_minimal()

# Install the ggthemes package
# Load the ggthemes package
# Use one of themes from the package to update your last plot
# The themes can be found here:
# https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/

library(ggthemes)

ggplot(data = penguins_by_species,
       mapping = aes(x = species,
                     y = n,
                     fill = species,
                     label = n)) +
  geom_col() +
  geom_label(vjust = -0.5,
             color = "white") +
  scale_fill_viridis_d() +
  scale_y_continuous(limits = c(0, 160),
                     breaks = c(0, 40, 80, 120, 160)) +
  labs(title = "Number of penguins by species",
       x = NULL,
       y = NULL) +
  theme_fivethirtyeight()

# Facets ------------------------------------------------------------------

# I've written code to give you a data frame to work with
# Run the code and take a look at the penguin_weight_by_species_and_sex data frame

penguin_weight_by_species_and_sex <- penguins |> 
  drop_na(sex) |> 
  group_by(species, sex) |> 
  summarize(mean_weight = mean(body_mass_g))

# Now see if you can recreate this plot:
# 

ggplot(data = penguin_weight_by_species_and_sex,
       mapping = aes(x = species,
                     y = mean_weight,
                     fill = sex)) +
  geom_col() +
  facet_grid(cols = vars(sex)) +
  theme_minimal() +
  labs(title = "Average penguin weight by sex and species",
       x = NULL,
       y = NULL)

ggsave(filename = "plots/penguins-by-weight-species.pdf",
       height = 8,
       width = 11,
       units = "in")

