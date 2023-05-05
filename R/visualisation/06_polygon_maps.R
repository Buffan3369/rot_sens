# ------------------------------------------------------------------------- #
# Purpose: Plot continental polygon maps
# Author(s): Lucas Buffan & Lewis A. Jones
# Email: Lucas.L.Buffan@gmail.com; LewisAlan.Jones@uvigo.es
# Load libraries ----------------------------------------------------------
library(ggplot2)
library(cowplot)
library(raster)
library(sf)
# Load --------------------------------------------------------------------
# Set up bounding box
ras <- raster::raster(res = 5, val = 1)
ras <- rasterToPolygons(x = ras, dissolve = TRUE)
# Robinson projection
bb <- sf::st_as_sf(x = ras)
bb <- st_transform(x = bb, crs = "ESRI:54030")

# Load polygons and project to robinson
# Golonka polygons
golonka <- sf::read_sf("https://gws.gplates.org/reconstruct/coastlines/?&time=0&model=GOLONKA")

# Scotese polygons
paleomap <- sf::read_sf("https://gws.gplates.org/reconstruct/coastlines/?&time=0&model=PALEOMAP")

# Matthews polygons
matthews <- sf::read_sf("https://gws.gplates.org/reconstruct/coastlines/?&time=0&model=MATTHEWS2016_pmag_ref")

# Merdith polygons
merdith <- sf::read_sf("https://gws.gplates.org/reconstruct/coastlines/?&time=0&model=MERDITH2021")

# Torsvik and Coks polygons
tc <- sf::read_sf("https://gws.gplates.org/reconstruct/static_polygons/?time=0&model=TorsvikCocks2017&anchor_plate_id=1")

# Plot --------------------------------------------------------------------
# Plot function
plot_map <- function(x, main, bb){
  ggplot(x) + 
    geom_sf(data = bb, fill = "lightblue", col = NA) +
    geom_sf(size = 0.1) +
    labs(title = main) +
    theme_void() +
    theme(
      plot.margin = margin(5, 5, 5, 5, "mm"),
      axis.text = element_blank(),
      plot.title = element_text(hjust = 0.5, size = 12)) +
    coord_sf(crs = sf::st_crs("ESRI:54030"))
}
# Create plots
p1 <- plot_map(golonka, main = "Wright et al. (2013)", bb = bb)
p2 <- plot_map(tc, main = "Torsvik and Cocks (2016)", bb = bb)
p3 <- plot_map(matthews, main = "Matthews et al. (2016)", bb = bb)
p4 <- plot_map(paleomap, main = "Scotese & Wright (2018)", bb = bb)
p5 <- plot_map(merdith, main = "Merdith et al. (2021)", bb = bb)

# Combine plots -----------------------------------------------------------
# Arrange plot
top_row <- cowplot::plot_grid(p1, p2, p3, NULL, 
                              labels = c("(a)", "(b)", "(c)", NA),
                              ncol = 4,
                              label_size = 18,
                              rel_widths = c(1/3, 1/3, 1/3, 0))
bottom_row <- cowplot::plot_grid(NULL, p4, p5, NULL,
                                 labels = c(NA, "(d)", "(e)", NA),
                                 label_size = 18,
                                 ncol = 4,
                                 rel_widths = c(0.125, 0.25, 0.25, 0.125))
p <- cowplot::plot_grid(top_row, bottom_row, nrow = 2)
# Save plot
ggsave(filename = "./figures/continental_polygons.png",
       height = 150,
       width = 300,
       units = "mm",
       bg = "white",
       dpi = 600)
