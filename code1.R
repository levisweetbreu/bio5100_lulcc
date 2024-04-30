# Load required libraries
library(raster)
library(dplyr)
library(tidyr)

# Load the two NLCD rasters for different years
raster1 <- raster("C:\\Users\\levis\\OneDrive - Baylor University\\2024\\Spring_Classes\\BioSeminar\\bio5100_lulcc\\rasters\\SA_2016.tif")
raster2 <- raster("C:\\Users\\levis\\OneDrive - Baylor University\\2024\\Spring_Classes\\BioSeminar\\bio5100_lulcc\\rasters\\SA_2019.tif")

# Extract the values of the rasters as factors
values1 <- as.factor(getValues(raster1))
values2 <- as.factor(getValues(raster2))

# Create a data frame with transitions
transition_df <- data.frame(from_class = values1, to_class = values2)

# Remove NA values (if any)
transition_df <- na.omit(transition_df)

# Count the transitions using dplyr
transition_counts <- transition_df %>%
  group_by(from_class, to_class) %>%
  summarise(count = n()) %>%
  arrange(from_class, to_class)

# Export the transition counts to a CSV file
write.csv(transition_counts, file = "C:\\Users\\levis\\OneDrive - Baylor University\\2024\\Spring_Classes\\BioSeminar\\bio5100_lulcc\\transition_counts.csv", row.names = FALSE)
