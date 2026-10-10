# Install packages
pak::pkg_install(c("ggsci", "ggthemes", "hrbrthemes"))

# load the package
library(tidyverse)
library(ggsci)
library(ggthemes)
library(hrbrthemes)

# import data
penguins_data <- penguins

# data visualization template
ggplot(data, aes(x = , y = )) +
  geom_type()

# histogram
basic <- ggplot(penguins_data, aes(x = body_mass)) +
  geom_histogram() +
  labs(
    x = "Body Mass",
    y = "Frequency",
    title = "Distribution of body mass",
    subtitle = "A subtitle",
    caption = "Data Source: RStudio"
  )

# themes
basic + theme_economist()
basic + theme_bw()
basic + theme_ipsum_pub()

# journal color themes
basic + scale_fill_npg()
basic + scale_fill_lancet()

# density
ggplot(penguins_data, aes(x = body_mass)) +
  geom_density()

# boxplot
ggplot(penguins_data, aes(x = sex, y = body_mass)) +
  geom_boxplot()

# bar chart
penguins_data |>
  filter(sex != "NA") |>
  ggplot(aes(sex)) +
    geom_bar()

# color by category or group
plot <- penguins_data |>
  filter(sex != "NA") |>
  ggplot(aes(body_mass, fill = sex)) +
  geom_density() +
  facet_wrap(~sex)

plot + theme(legend.position = "top")
plot + theme(legend.title = element_text(size = 20, family = "Arial"))
ggsave("figures/boday_max.png", dpi = 300)
