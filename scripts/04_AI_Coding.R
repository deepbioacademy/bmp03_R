# Install packages if you haven't already:
install.packages(c("ggplot2", "GGally", "dplyr", "viridis", "corrplot"))

library(ggplot2)
library(GGally)
library(dplyr)
library(viridis)

# Define a clean, colorblind-friendly palette
pub_colors <- c("#D55E00", "#009E73", "#0072B2") # Vermillion, Bluish Green, Blue

# Custom theme modifications for publication standards
pub_theme <- theme_bw(base_size = 11, base_family = "sans") +
  theme(
    panel.grid.minor = element_blank(),
    strip.background = element_rect(fill = "white", color = "black", linewidth = 0.5),
    strip.text = element_text(face = "bold", size = 10),
    legend.position = "bottom"
  )

# Select numerical variables and species for grouping
penguins_data <- penguins
penguin_subset <- penguins_data %>%
  select(bill_len, bill_dep, flipper_len, body_mass, species) %>%
  na.omit()

# Generate the pair plot
p_pairs <- ggpairs(
  penguin_subset,
  columns = 1:4,
  mapping = aes(color = species, alpha = 0.7),
  lower = list(continuous = wrap("smooth", method = "lm", se = FALSE, linewidth = 0.8)),
  diag = list(continuous = wrap("densityDiag", alpha = 0.5)),
  upper = list(continuous = wrap("cor", size = 3, fontface = "bold"))
) +
  scale_color_manual(values = pub_colors) +
  scale_fill_manual(values = pub_colors) +
  pub_theme

print(p_pairs)

p_scatter <- ggplot(penguins_data, aes(x = flipper_len, y = body_mass, color = species, shape = species)) +
  geom_point(size = 2.5, alpha = 0.8) +
  geom_smooth(method = "lm", se = TRUE, linewidth = 1, alpha = 0.15) +
  scale_color_manual(values = pub_colors) +
  scale_shape_manual(values = c(16, 17, 18)) + # Different shapes for clarity
  labs(
    x = "Flipper Length (mm)",
    y = "Body Mass (g)",
    color = "Species",
    shape = "Species",
    title = "Body Mass Scaling by Flipper Length"
  ) +
  theme_classic(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 14),
    axis.title = element_text(face = "bold"),
    legend.position = c(0.15, 0.85),
    legend.background = element_rect(fill = alpha("white", 0.8), color = NA)
  )

print(p_scatter)

# Compute correlation matrix for numeric columns
numeric_vars <- penguins_data %>%
  select(bill_len, bill_dep, flipper_len, body_mass, year) %>%
  na.omit()

corr_matrix <- cor(numeric_vars)

# Reshape for ggplot
library(reshape2)
corr_melted <- melt(corr_matrix)

p_heat <- ggplot(corr_melted, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_viridis(option = "plasma", limits = c(-1, 1), name = "Pearson's r") +
  geom_text(aes(label = round(value, 2)), color = "black", size = 3.5) +
  labs(x = NULL, y = NULL, title = "Correlation Heatmap of Penguin Morphometrics") +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),
    axis.text.y = element_text(face = "bold"),
    panel.grid = element_blank(),
    plot.title = element_text(face = "bold", hjust = 0.5)
  )

print(p_heat)
