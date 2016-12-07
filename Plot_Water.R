# Author WF835334 

library(maptools)
#Sets Projection
crswgs84=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")

# Data downloaded from https://catalog.data.gov/dataset/usgs-small-scale-dataset-streams-and-waterbodies-of-the-united-states-200512-shapefile

# Reads ploygon shapefile
water=readShapePoly("hydrogp020.shp",proj4string=crswgs84,verbose=TRUE)
summary(water)
# Reads linear shapefile
lines=readShapeLines("hydrogl020.shp",proj4string=crswgs84,verbose=TRUE)
summary(lines)
# Removes features classified as shorelines 
linesnoshore <- subset(lines, FEATURE != "Shoreline")
#Removes features classified as NULL, if this step is ignored, plot will fill all areas, including null, thus getting a completely filled plot
waternonull <- subset(water, FEATURE != "Null")
linenonull <- subset(linesnoshore, FEATURE != "Null")
#Removes features classified as Bay or Estuary or Ocean, this step can be commented out (just remember to plot the correct dataset if you do)
waterB <- subset(waternonull, FEATURE != "Bay or Estuary or Ocean")
#Plots the CONUS US water bodies 
plot(waterB,xlim = c(-126,-66), ylim = c( 25, 50), col = "dodgerblue", xaxt = 'n' , yaxt = 'n', ann = FALSE, border = "dodgerblue")
plot(linenonull, xlim = c(-126,-66), ylim = c( 25, 50), col = "dodgerblue", add = TRUE)
#I usually save the image as a US Legal PDF format and convert to a PNG later)

