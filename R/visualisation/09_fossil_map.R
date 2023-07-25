# ------------------------------------------------------------------------- #
# Purpose: Plot Modern polygon maps with fossil occurrences
# Author(s): Lucas Buffan & Lewis A. Jones
# Email: Lucas.L.Buffan@gmail.com; LewisAlan.Jones@uvigo.es

# Load libraries ----------------------------------------------------------
library(ggplot2)
library(ggpubr)
library(sf)
library(deeptime)

# Load --------------------------------------------------------------------
reef <- readRDS("./data/occurrences/cleaned_reef_dataset.RDS")
croc <- readRDS("./data/occurrences/cleaned_croc_dataset.RDS")
world <- map_data("world")


# Plot ------------------------------------------------------------------
reef$colour <- cut(reef$bin_mid_ma, c(periods$min_age, periods$max_age[22]), periods$name)

reef <- ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = "lightgrey", colour = "black", linewidth = 0.1) +
  geom_point(data = reef, aes(x = lng, y = lat, colour = colour),
             size = 1, alpha = 0.75) +
  scale_color_geo("periods", name = "Period") +
  labs(title = "Coral reefs") +
  theme_void() +
  theme(plot.margin = margin(0, 0, 0, 0, "mm"),
        legend.position = "bottom",
        legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5)) +
  coord_sf() + 
  guides(color = guide_legend(override.aes = list(size=3))) 

croc$colour <- cut(croc$bin_mid_ma, c(periods$min_age, periods$max_age[22]), periods$name)

croc <- ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = "lightgrey", colour = "black", linewidth = 0.1) +
  geom_point(data = croc, aes(x = lng, y = lat, colour = colour),
             size = 1, alpha = 0.75) +
  scale_color_geo("periods", name = "Period") +
  labs(title = "Crocodylomorphs") +
  theme_void() +
  theme(plot.margin = margin(0, 0, 0, 0, "mm"),
        legend.position = "bottom",
        legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5)) +
  coord_sf() + 
  guides(color = guide_legend(override.aes = list(size=3)))

# Combine plots -----------------------------------------------------------
# Arrange plot
p <- ggarrange(reef, croc, nrow = 2,
               labels = c("(a)", "(b)"),
               font.label = list(size = 16), align = "hv")
p
# Save plot
ggsave(filename = "./figures/fossil_map.png",
       height = 200,
       width = 175,
       units = "mm",
       bg = "white",
       dpi = 300,
       scale = 1)
