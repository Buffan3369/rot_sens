# Script details ----------------------------------------------------------
# Purpose: Calculate latitudinal standard deviation
# Author(s): Lucas Buffan & Lewis A. Jones
# Email: Lucas.L.Buffan@gmail.com; LewisAlan.Jones@uvigo.es
# Load libraries ----------------------------------------------------------
library(tidyverse)
library(matrixStats)

# Analysis ----------------------------------------------------------------
# Define available models
models <- c("WR13", "TC17", "SC16", "ME21", "MA16")

# Load model files --------------------------------------------------------
for (i in models) {
  assign(i,
         readRDS(file = paste0("./data/grid_palaeocoordinates/", i, ".RDS")))
}

# Get lat indexes columns for SD calculation
lat_indx <- grep("lat", colnames(SC16))
lat_indx <- lat_indx[!(lat_indx == 2)] #remove index corresponding to t = 0

# Create empty dataframe for populating
df_sd <- matrix(ncol = length(lat_indx), nrow = nrow(SC16))
df_sd <- data.frame(df_sd)
# Add col names
colnames(df_sd) <- colnames(SC16)[lat_indx]

# Calculate row SD
for (i in 1:length(lat_indx)) {
  wc <- lat_indx[i]
  mat <- data.frame(TC17[, wc],
                    MA16[, wc],
                    WR13[, wc],
                    SC16[, wc],
                    ME21[, wc])
  row_sd <- apply(X = mat, 
                  MARGIN = 1,
                  FUN = sd,
                  na.rm = TRUE)
  df_sd[, i] <- row_sd
}

# Tidy up and save --------------------------------------------------------
ref_coords <- SC16[, c("lng", "lat")] #reference (=present-day) coordinates
df_sd <- cbind.data.frame(ref_coords, df_sd)
saveRDS(df_sd, file = "./results/lat_SD.RDS")

## Ncells counter ---------------------------------------------------------
ncells_over_time <- vector("numeric")
# Count number of NA cells over time
for (i in 3:ncol(df_sd)) {
  ncells_over_time[i-2] <- nrow(df_sd) - sum(is.na(df_sd[, i]))
}
t <- seq(from = 10, to = 540, by = 10)
plot(x = t, y = ncells_over_time)
