library(tidyverse)

#Set WD [households, persons, trips, TAZ files must be in same dir]
setwd("~/RA_Microtransit/files_to_kepp/activitysim_output")

#Read in .csv's
if(exists('allHouseholds') == FALSE) allHouseholds <- read_csv("final_households.csv")
if(exists('allPersons') == FALSE) allPersons <- read_csv("final_persons.csv")
if(exists('allTrips') == FALSE) allTrips <- read_csv("final_trips.csv")
TAZinZone <- unname(deframe(read_csv("TAZ_in_Zone.csv")))

#Set percent of people to sample
pctInZone = 10
pctOutZone = 1

#Set output folder naming scheme
outputFolder <- paste("SampleFiles_",pctInZone,"-",pctOutZone, sep = "")

###############################################################################

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
dir.create(outputFolder)
write_csv(sampleHouseholds, paste(getwd(),"/",outputFolder,"/households.csv", sep = ""))
write_csv(samplePersons, paste(getwd(),"/",outputFolder,"/persons.csv", sep = ""))
write_csv(sampleTrips, paste(getwd(),"/",outputFolder,"/trips.csv", sep = ""))
