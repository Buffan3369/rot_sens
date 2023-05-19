# ------------------------------------------------------------------------- #
# Purpose: Run main data analysis scripts
# Author(s): Lucas Buffan & Lewis A. Jones
# Email: Lucas.L.Buffan@gmail.com; LewisAlan.Jones@uvigo.es
# Simulation component ----------------------------------------------------
## Scale reconstruction files to equal spatial coverage -------------------
source("./R/data_analysis/01_spatial_coverage.R")
rm(list = ls())

## Comparison  ------------------------------------------------------------
# Latitudinal standard deviation
source("./R/data_analysis/02_lat_sd.R") 
rm(list = ls())

# Calculate average geodesic distance between points
source("./R/data_analysis/03_average_geodesic_distance.R")
rm(list = ls())

# Case study --------------------------------------------------------------
## Data pre-processing ----------------------------------------------------
# Clean coral data
source("./R/data_analysis/04_prepare_fossil_reef_data.R")
rm(list = ls())

# Clean croc data
source("./R/data_analysis/05_prepare_fossil_croc_data.R")
rm(list = ls())