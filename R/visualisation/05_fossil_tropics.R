# ------------------------------------------------------------------------- #
# Purpose: Plot latitudinal limits
# Author(s): Lucas Buffan & Lewis A. Jones
# Email: Lucas.L.Buffan@gmail.com; LewisAlan.Jones@uvigo.es
# Load libraries ----------------------------------------------------------
library(ggplot2)
library(ggpubr)
library(deeptime)
library(Hmisc)
pal <- rev(c('#41ab5d','#006837','#004529', '#dd3497','#7a0177','#49006a'))
shps <- c(3, 10, 15, 16, 17, 18, 20)
# Coral reef --------------------------------------------------------------
reefs <- readRDS("./data/fossil_palaeocoordinates/reef_palaeoccordinates_5_models.RDS")
df <- data.frame(time = rep(seq(from = 5, to = 235, by = 10), times = 5),
                 entity = "Coral Reef",
                 max = NA,
                 model = rep(colnames(reefs)[5:9], each = 24))
reefs$bin <- NA
bins <- seq(from = 5, to = 235, by = 10)
for(bin in bins){
  if(bin == 5){
    reefs$bin[which(reefs$time < bin)] <- bin
  }
  else{
    reefs$bin[which((reefs$time >= bin-10) & (reefs$time < bin))] <- bin
  }
}
for(mdl in colnames(reefs)[5:9]){
  tmp <- reefs[, c("bin", mdl)]
  # Max lat per bin
  for (j in bins) {
    # If no vals available skip
    if (nrow(tmp[which(tmp$bin == j), ]) == 0) {next}
    # If all values are NA, skip
    if (all(is.na(tmp[which(tmp$bin == j), c(mdl)]))) {next}
    # Get maximum absolute latitude
    val <- max(abs(tmp[which(tmp$bin == j), c(mdl)]), na.rm = TRUE)
    # Add to dataframe
    df$max[which(df$time == j & df$model == mdl)] <- val
  }
 }

# Calculate ribbon coordinates
rib <- data.frame(time = bins, max = NA, min = NA, model = NA)
for (i in 1:nrow(rib)) {
  rib$max[i] <- max(df$max[which(df$time == rib$time[i])], na.rm = TRUE)
  rib$min[i] <- min(df$max[which(df$time == rib$time[i])], na.rm = TRUE)
}
# Update -Inf values (no coral reef in this bin)
rib[which(is.infinite(rib$max)), c("max", "min")] <- NA

# Correlation between time and ribbon width (i.e palaeolatitudinal uncertainty)
r <- Hmisc::rcorr(x = rib$time, y = abs(rib$max - rib$min), type = "pearson")
print(paste0("Coral time~uncertainty correlation coefficient (r): ", round(r$r[1,2], digits = 2)))
print(paste0("Coral time~uncertainty correlation p-value (p): ", round(r$P[1,2], digits = 7)))
print(paste0("Coral average uncertainty is: ", mean(abs(rib$max - rib$min), na.rm = TRUE)))
#plot
p1 <- ggplot(data = df, aes(x = time, y = max, colour = model, shape = model)) +
        #geom_line(size = 1) +
        geom_ribbon(data = rib, aes(x = time, ymin = min, ymax = max),
                    fill = "grey80",
                    colour = "grey80") +
        geom_point(size = 3.5, stroke = 0.5, alpha = 0.75) +
        labs(title = "Coral Reefs",
             x = "Time (Ma)",
             y = "Absolute Palaeolatitude (\u00B0)",
             colour = "Model",
             shape = "Model") +
        scale_colour_manual(values = pal) +
        scale_shape_manual(values = shps) +
        scale_y_continuous(limits = c(0, 70), 
                           breaks = seq(0, 70, 15),
                           labels = seq(0, 70, 15)) + 
        scale_x_reverse(limits = c(200, 0)) +
        theme(plot.margin = margin(5, 10, 5, 10, "mm"),
              axis.title.x = element_text(size = 14),
              axis.title.y = element_text(size = 14),
              axis.text = element_text(size = 12),
              legend.background = element_blank(),
              legend.title = element_blank(),
              legend.text = element_text(size = 12),
              legend.key.size = unit(0.6, "cm"),
              legend.position = c(0.85, 0.13),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(), 
              panel.background = element_blank(),
              panel.border = element_rect(colour = "black", fill = NA, size = 0.5)) +
        deeptime::coord_geo(pos = "bottom", fill = "grey95", height = unit(1.5, "line")) +
  guides(colour=guide_legend(ncol=2))
# Crocs -------------------------------------------------------------------
crocs <- readRDS("./data/fossil_palaeocoordinates/croc_palaeoccordinates_5_models.RDS")
df <- data.frame(time = rep(seq(from = 5, to = 235, by = 10), times = 5),
                 entity = "Coral croc",
                 max = NA,
                 model = rep(colnames(crocs)[5:9], each = 24))
crocs$bin <- NA
bins <- seq(from = 5, to = 235, by = 10)
for(bin in bins){
  if(bin == 5){
    crocs$bin[which(crocs$time < bin)] <- bin
  }
  else{
    crocs$bin[which((crocs$time >= bin-10) & (crocs$time < bin))] <- bin
  }
}
for(mdl in colnames(crocs)[5:9]){
  tmp <- crocs[, c("bin", mdl)]
  # Max lat per bin
  for (j in bins) {
    # If no vals available skip
    if (nrow(tmp[which(tmp$bin == j), ]) == 0) {next}
    # If all values are NA, skip
    if (all(is.na(tmp[which(tmp$bin == j), c(mdl)]))) {next}
    # Get maximum absolute latitude
    val <- max(abs(tmp[which(tmp$bin == j), c(mdl)]), na.rm = TRUE)
    # Add to dataframe
    df$max[which(df$time == j & df$model == mdl)] <- val
  }
}
# Calculate ribbon coordinates
rib <- data.frame(time = bins, max = NA, min = NA, model = NA)
for (i in 1:nrow(rib)) {
  rib$max[i] <- max(df$max[which(df$time == rib$time[i])])
  rib$min[i] <- min(df$max[which(df$time == rib$time[i])])
}

# Correlation between time and ribbon width (i.e palaeolatitudinal uncertainty)
r <- Hmisc::rcorr(x = rib$time, y = (rib$max - rib$min), type = "pearson")
print(paste0("Crocs time~uncertainty correlation coefficient (r): ", round(r$r[1,2], digits = 2)))
print(paste0("Crocs time~uncertainty correlation p-value (p): ", round(r$P[1,2], digits = 7)))
print(paste0("Crocs average uncertainty is: ", mean(abs(rib$max - rib$min), na.rm = TRUE)))

#plot
p2 <- ggplot(data = df, aes(x = time, y = max, colour = model, shape = model)) +
        #geom_line(size = 1) +
        geom_ribbon(data = rib, aes(x = time, ymin = min, ymax = max),
                    fill = "grey80",
                    colour = "grey80") +
        geom_point(size = 3.5, stroke = 0.5, alpha = 0.75) +
        labs(title = "Crocodylomorphs",
             x = "Time (Ma)",
             y = "Absolute Palaeolatitude (\u00B0)",
             colour = "Model",
             shape = "Model") +
        scale_colour_manual(values = pal) +
        scale_shape_manual(values = shps) +
        scale_y_continuous(limits = c(35, 85), 
                           breaks = seq(35, 85, 15),
                           labels = seq(35, 85, 15)) + 
        scale_x_reverse(limits = c(200, 0)) +
        theme(plot.margin = margin(5, 10, 5, 10, "mm"),
              axis.title.x = element_text(size = 14),
              axis.title.y = element_text(size = 14),
              axis.text = element_text(size = 12),
              legend.background = element_blank(),
              legend.title = element_blank(),
              legend.text = element_text(size = 12),
              legend.key.size = unit(0.6, "cm"),
              legend.position = c(0.16, 0.88),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(), 
              panel.background = element_blank(),
              panel.border = element_rect(colour = "black", fill = NA, size = 0.5)) +
        deeptime::coord_geo(pos = "bottom", fill = "grey95", height = unit(1.5, "line")) +
  guides(colour=guide_legend(ncol=2))

# Combine plots -----------------------------------------------------------
# Arrange plot
p <- ggarrange(p1, p2, ncol = 1, nrow = 2, labels = c("(a)", "(b)"),
               font.label = list(size = 20))
# Save plot
ggsave(filename = "./figures/tropical_extent.png",
       height = 250,
       width = 210,
       units = "mm",
       dpi = 600)
