# Load Packages -----------------------------------------------------------

library(tidyverse)

# Import Data -------------------------------------------------------------

penguins <- read_csv("penguins.csv")

# Scatterplots ------------------------------------------------------------

# We use geom_point() to make a scatterplot.

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,
                     y = bill_depth_mm)) +
  geom_point()

# Histograms --------------------------------------------------------------

# We use geom_histogram() to make a histogram.

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm)) +
  geom_histogram()

# How does ggplot know what to plot on the y axis? 
# It's using the default statistical transformation for geom_histogram, 
# which is stat = "bin".

# If we add stat = "bin" we get the same thing. Each geom has a default stat.

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm)) +
  geom_histogram(stat = "bin")

# We can adjust the number of bins using the bins argument. 

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm)) +
  geom_histogram(bins = 100)


# Bar Charts --------------------------------------------------------------

# There are two basic approaches to making bar charts, both of which use geom_bar().

# Approach #1

# Use your full dataset.
# Only assign a variable to the x axis.
# Let ggplot use the default stat transformation (stat = "count") 
# to generate counts that it then plots on the y axis.

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm)) +
  geom_bar()

# The default statistical transformation for geom_bar() is count. 
# This will give us the same result as our previous plot.

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm)) +
  geom_bar(stat = "count")


# Approach #2

# Wrangle your data frame before plotting, possibly creating a new data frame in the process
# Assign variables to the x and y axes
# Use stat = "identity" to tell ggplot to use the data exactly as it is

# It's often easier to do our analysis work, save a data frame, and then use this to plot.
# Let's recreate our penguin_bill_length_by_island data frame.

penguin_bill_length_by_island <- penguins |> 
  group_by(island) |> 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE)) |> 
  arrange(mean_bill_length)

# Then let's use this data frame to make a bar chart. 
# The stat = "identity" here tells ggplot to use the exact data points
# without any statistical transformations.

ggplot(data = penguin_bill_length_by_island,
       mapping = aes(x = island,
                     y = mean_bill_length)) +
  geom_bar(stat = "identity")

# We can also flip the x and y axes. 

ggplot(data = penguin_bill_length_by_island,
       mapping = aes(x = island,
                     y = mean_bill_length)) +
  geom_bar(stat = "identity") +
  coord_flip()

# The function coord_flip() will do the same thing.

ggplot(data = penguin_bill_length_by_island,
       mapping = aes(x = mean_bill_length,
                     y = island)) +
  geom_bar(stat = "identity")

# We can also use geom_col(), which is the same as geom_bar(stat = "identity")

ggplot(data = penguin_bill_length_by_island,
       mapping = aes(x = island,
                     y = mean_bill_length)) +
  geom_col()


# Setting color and fill Aesthetic Properties -----------------------------

# We add the color argument within aes() so that 
# the data in that variable is mapped to those aesthetic properties.

# With this code, the island variable is mapped to the aesthetic property color

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,
                     y = bill_depth_mm,
                     color = island)) +
  geom_point()

# Let's try the same thing with our bar chart

ggplot(data = penguin_bill_length_by_island,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     color = island)) +
  geom_col()

# That didn't work! Let's try fill instead.

ggplot(data = penguin_bill_length_by_island,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island)) +
  geom_col()


# Setting color and fill scales -------------------------------------------

# We can change the color or fill scale using a scale function.

# The function scale_color_manual() allows us to manually specify colors to use.

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,
                     y = bill_depth_mm,
                     color = island)) +
  geom_point() +
  scale_color_manual(values = c("orange", "dodgerblue", "green"))

# We can also use built-in palettes. 

# The scale_color_viridis_d() function (the d means it works with discrete data)
# is a great way to get colorblind-friendly palettes.

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,
                     y = bill_depth_mm,
                     color = island)) +
  geom_point() +
  scale_color_viridis_d()

# The scale_color_viridis_d() function also has several built-in palettes.
# You can use them as follows.

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,
                     y = bill_depth_mm,
                     color = island)) +
  geom_point() +
  scale_color_viridis_d(option = "A")

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,
                     y = bill_depth_mm,
                     color = island)) +
  geom_point() +
  scale_color_viridis_d(option = "F")

# There are many other built-in palettes. Just type scale_color_ and RStudio
# will autocomplete some other options for you.

# We can use scale_fill_viridis_d() for the fill aesthetic property.

ggplot(data = penguin_bill_length_by_island,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island)) +
  geom_col() +
  scale_fill_viridis_d()

# Setting x and y Scales --------------------------------------------------

# Adjusting our x and y axes is similar. 
# Remember that the x and y axes are considered an aesthetic properties in the same way color is.

# We adjust our x and y axes using the scale_ set of functions. 
# The exact function you use depends on your data. 
# For example, you would use scale_y_continuous() if you have continuous data on the y axis.

# The limits argument sets the minimum and maximum values that display.

ggplot(data = penguin_bill_length_by_island,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island)) +
  geom_col() +
  scale_y_continuous(limits = c(0, 50))

# The breaks argument determines which axis labels show up.

ggplot(data = penguin_bill_length_by_island,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island)) +
  geom_col() +
  scale_y_continuous(limits = c(0, 50),
                     breaks = c(0, 10, 20, 30, 40, 50))

# If we want to change the x axis labels, we'd need to use 
# the labels argument in scale_x_discrete() because that data is categorical. 

ggplot(data = penguin_bill_length_by_island,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island)) +
  geom_col() +
  scale_y_continuous(limits = c(0, 50),
                     breaks = c(0, 10, 20, 30, 40, 50)) +
  scale_x_discrete(labels = c("Biscoe Island", 
                              "Dream Island",
                              "Torgersen Island"))

# Text and Labels ---------------------------------------------------------

# Text is just another geom. 
# We can use geom_text() to add labels to our figures.

ggplot(data = penguin_bill_length_by_island,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island,
                     label = mean_bill_length)) +
  geom_col() +
  geom_text()

# Those text labels are too long!
# Let's create a new variable to use for plotting.
# We're using the number function from the scales package to make this variable

library(scales)

penguin_bill_length_by_island_v2 <- penguin_bill_length_by_island |> 
  mutate(mean_bill_length_one_digit = number(mean_bill_length, accuracy = 0.1))

# Now let's plot using our new data frame

ggplot(data = penguin_bill_length_by_island_v2,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island,
                     label = mean_bill_length_one_digit)) +
  geom_col() +
  geom_text()

# Note that we use mean_bill_length_one_digit for the label aesthetic property
# and mean_bill_length for y. 
# If you use mean_bill_length_one_digit for both, your graph will look different.

ggplot(data = penguin_bill_length_by_island_v2,
       mapping = aes(x = island,
                     y = mean_bill_length_one_digit,
                     fill = island,
                     label = mean_bill_length_one_digit)) +
  geom_col() +
  geom_text()

# We can use the hjust() and vjust() arguments to horizontally and vertically adjust text.

# vjust = 0 puts the labels on the outer edge of the bars.

ggplot(data = penguin_bill_length_by_island_v2,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island,
                     label = mean_bill_length_one_digit)) +
  geom_col() +
  geom_text(vjust = 0)

# vjust = 1 puts the labels at the inner edge of the bars.

ggplot(data = penguin_bill_length_by_island_v2,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island,
                     label = mean_bill_length_one_digit)) +
  geom_col() +
  geom_text(vjust = 1)

# I often do something like vjust = 1.5 to give a bit more padding. 

ggplot(data = penguin_bill_length_by_island_v2,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island,
                     label = mean_bill_length_one_digit)) +
  geom_col() +
  geom_text(vjust = 1.5)

# We can adjust the color of the text using the color argument. 
# We're putting it outside of the aes() because we are setting it for the whole layer.

ggplot(data = penguin_bill_length_by_island_v2,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island,
                     label = mean_bill_length_one_digit)) +
  geom_col() +
  geom_text(vjust = 1.5,
            color = "white")

# geom_label() is nearly identical but it adds a background. 
# With geom_label() the color argument determines the text and border color 
# while the fill is the background color.

ggplot(data = penguin_bill_length_by_island_v2,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = island,
                     label = mean_bill_length_one_digit)) +
  geom_col() +
  geom_label(vjust = 1.5,
            color = "white",
            fill = "black")


# Plot Labels -------------------------------------------------------------

# To start, let's make a new data frame

penguin_bill_length_by_island_and_sex <- penguins |> 
  drop_na(sex) |> 
  group_by(island, sex) |> 
  summarize(mean_bill_length = mean(bill_length_mm))

# Now let's plot this data frame using a bar chart.

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col()

# The bars are stacked by default. 
# To put them side by side, we use the position = "dodge" argument within geom_col().

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge")

# To add labels to our plot, we use labs().

# We can add a title to the plot with the title argument.

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females")

# We can also add a subtitle and caption

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package")

# We can change the x and y axis labels using the x and y arguments.

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package",
       x = "Island",
       y = "Mean Bill Length in Millimeters")

# To change the legend title, we use the name of the aesthetic that is being shown.

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package",
       x = "Island",
       y = "Mean Bill Length in Millimeters",
       fill = "Sex")

# You can remove titles using NULL

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package",
       x = NULL,
       y = "Mean Bill Length in Millimeters",
       fill = NULL)


# Themes ------------------------------------------------------------------

# To add a theme to a plot, we use the theme_ set of functions. 
# There are several built-in themes. For instance, theme_minimal().

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package",
       x = NULL,
       y = "Mean Bill Length in Millimeters",
       fill = NULL) +
  theme_minimal()

# There's also theme_light().

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package",
       x = NULL,
       y = "Mean Bill Length in Millimeters",
       fill = NULL) +
  theme_light()

# There are also packages that give you themes you can apply to your plots. 
# Let's load the ggthemes() package
# Install it if necessary using install.packages("ggthemes")

library(ggthemes)

# We can then use a theme from this package called theme_economist()
# to make our plots look like those in the Economist.

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package",
       x = NULL,
       y = "Mean Bill Length in Millimeters",
       fill = NULL) +
  theme_economist()

# You can see a number of other themes from this package at
# https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/


# Facets ------------------------------------------------------------------

# One of the most powerful features of ggplot is facetting. 
# You can make small multiples by adding just a line of code.

# The facet_wrap() function will create small multiples.

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package",
       x = NULL,
       y = "Mean Bill Length in Millimeters",
       fill = NULL) +
  theme_economist() +
  facet_wrap(vars(sex))

# You can do something similar with the facet_grid() function.
# With this function, you can specify whether you want the facetting 
# on rows or columns.

# This is identical to the facet_wrap() above.

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package",
       x = NULL,
       y = "Mean Bill Length in Millimeters",
       fill = NULL) +
  theme_economist() +
  facet_grid(cols = vars(sex))

# This puts the result in two rows.

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package",
       x = NULL,
       y = "Mean Bill Length in Millimeters",
       fill = NULL) +
  theme_economist() +
  facet_grid(rows = vars(sex))

# We can use facetting for any type of figure. 
# Here's our scatterplot from before with a theme and facetting by sex added 

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,
                     y = bill_depth_mm)) +
  geom_point() +
  theme_economist() +
  facet_grid(cols = vars(sex))

# You can even use multiple variables with facet_grid().

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,
                     y = bill_depth_mm)) +
  geom_point() +
  theme_economist() +
  facet_grid(rows = vars(year),
             cols = vars(sex))

# Save Plots --------------------------------------------------------------

# If you need to save a plot, you can use the ggsave() function.
# By default ggsave() will save the last plot you made.

# First we plot

ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package",
       x = NULL,
       y = "Mean Bill Length in Millimeters",
       fill = NULL) +
  theme_economist() +
  facet_grid(cols = vars(sex))

# Then we save

ggsave(filename = "plots/penguins-plot.png",
       height = 8,
       width = 11,
       units = "in",
       bg = "white"
       dpi = 300)

# We can save our plot to other formats as well. 
# PDF is a great option because it produces small file sizes and high-quality plots. 
# You don't need to list dpi here as PDFs are vector based.

ggsave(filename = "plots/penguins-plot.pdf",
       height = 8,
       width = 11,
       units = "in")

# You can also save a plot and then use that within ggsave()

penguins_plot <- ggplot(data = penguin_bill_length_by_island_and_sex,
       mapping = aes(x = island,
                     y = mean_bill_length,
                     fill = sex)) +
  geom_col(position = "dodge") +
  labs(title = "Males have longer bills than females",
       subtitle = "But they're all good penguins",
       caption = "Data from the palmerpenguins R package",
       x = NULL,
       y = "Mean Bill Length in Millimeters",
       fill = NULL) +
  theme_economist() +
  facet_grid(cols = vars(sex))

ggsave(plot = penguins_plot,
       filename = "plots/penguins-plot-2.pdf",
       height = 8,
       width = 11,
       units = "in")
