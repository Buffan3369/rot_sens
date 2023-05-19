# Script details ----------------------------------------------------------
# Purpose: Calculate average geodesic distance
# Author(s): Lucas Buffan & Lewis A. Jones
# Email: Lucas.L.Buffan@gmail.com; LewisAlan.Jones@uvigo.es
# WARNING: This script can take a while to run depending on the user's PC.
# Load libraries ----------------------------------------------------------
library(geosphere)
# Timesteps  -------------------------------------------------------------
timescale <- seq(from = 10, to = 540, by = 10)
# Load model outputs -----------------------------------------------------
# Define available models
models <- c("WR13", "TC17", "SC16", "ME21", "MA16")
# Load
for (i in models) {
  assign(i,
         readRDS(file = paste0("./data/grid_palaeocoordinates//", i, ".RDS")))
}

# Calculate average geodesic distance ------------------------------------
# Convert to dataframe with reference coordinates
geodes <- data.frame(lng = SC16$lng,
                     lat = SC16$lat)
cnames <- c()
# Run for loop across time
for (t in timescale) {
  cnames <- c(cnames, paste0("Geodesic_dist_", t))
  col_indx <- c(paste0("lng_", t), paste0("lat_", t))
  gd_dist <- lapply(1:nrow(geodes), function(x) {
    tmp <- rbind(WR13[x, col_indx],
                 MA16[x, col_indx],
                 SC16[x, col_indx],
                 TC17[x, col_indx],
                 ME21[x, col_indx])
    dist_mat <- distm(tmp)
    dist_mat <- as.numeric(dist_mat[upper.tri(dist_mat, diag = FALSE)])
    mean(dist_mat, na.rm = TRUE) / (10^3)
  })
  gd_dist <- do.call(rbind, gd_dist)

  geodes <- cbind(geodes, gd_dist)
}
# Add column names
colnames(geodes) <- c("lng", "lat", cnames)
# Save data
saveRDS(geodes, "./results/geodesic_distance.RDS")
