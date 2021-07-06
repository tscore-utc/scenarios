##### User-entered Data #####

#Set percent of people to sample
pctInZone = 0.1
pctOutZone = 0.1

#Set ridehail zone name [must match "TAZ in zone" file naming scheme]
zoneName <- "slc_south"

#Set output folder naming scheme
outputFolderName <- paste(zoneName, "_",pctInZone,"-",pctOutZone, sep = "")

################################################################################
##### Code #####

library(tidyverse)

script.dir <- dirname(sys.frame(1)$ofile)

#Set WD for input files
setwd(paste(script.dir, "/../", "input_CSVs/activitysim_output", sep = ''))

#Set path of output folder
outputFolder <- paste(script.dir, "/../", "input_CSVs/", outputFolderName, sep = '')

#Read in CSVs
if(exists('allHouseholds') == FALSE) allHouseholds <- read_csv("households_all.csv")
if(exists('allPersons') == FALSE) allPersons <- read_csv("persons_all.csv")
if(exists('allTrips') == FALSE) allTrips <- read_csv("trips_all.csv")

#Read in TAZ in zone
TAZInZoneFile <- paste(script.dir, "/../", "input_CSVs/TAZ_zones/TAZInZone_", zoneName, ".csv", sep = '')
TAZinZone <- unname(deframe(read_csv(TAZInZoneFile)))

#Add column to Households if in Zone
allHouseholds['in_Zone'] <- deframe(allHouseholds['TAZ']) %in% TAZinZone

#Split households based on location
householdsInZone <- split(allHouseholds,allHouseholds['in_Zone'])$`TRUE`
householdsOutZone <- split(allHouseholds,allHouseholds['in_Zone'])$`FALSE`

#Calculate row numbers of households to keep
zoneRows <- round(seq(1, nrow(householdsInZone), 100/pctInZone))
noZoneRows <- round(seq(1, nrow(householdsOutZone), 100/pctOutZone))

#Create and combine sample households
sampleHouseholds <- rbind(householdsInZone[zoneRows,],householdsOutZone[noZoneRows,])

#Create persons and trips files based on sample households
allPersons['in_Zone'] <- deframe(allPersons['household_id']) %in% deframe(sampleHouseholds['household_id'])
samplePersons <- split(allPersons,allPersons['in_Zone'])$`TRUE`

allTrips['in_Zone'] <- deframe(allTrips['household_id']) %in% deframe(sampleHouseholds['household_id'])
sampleTrips <- split(allTrips,allTrips['in_Zone'])$`TRUE` %>% arrange(person_id,depart)


#Create output directory and write files
if(dir.exists(outputFolder) == FALSE) dir.create(outputFolder)
write_csv(sampleHouseholds, paste(outputFolder, "/households.csv", sep = ''))
write_csv(samplePersons, paste(outputFolder, "/persons.csv", sep = ''))
write_csv(sampleTrips, paste(outputFolder, "/trips.csv", sep = ''))

#Copy facility_ids and hhcoord to output directory
filesToCopyDir <- paste(script.dir, "/../", "input_CSVs/activitysim_output/", sep = '')
filesToCopy <- c(paste(filesToCopyDir, "facility_ids.csv", sep = ''), paste(filesToCopyDir, "hhcoord.csv", sep = ''))
file.copy(filesToCopy, outputFolder)