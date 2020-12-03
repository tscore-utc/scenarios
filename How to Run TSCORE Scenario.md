
# How to Run T-SCORE Scenarios #

When BEAM is executed, the MATSim engine manages loading of most data (population, households, vehicles, and the network used by PhysSim) as well as executing the MobSim -> Scoring -> Replanning iterative loop. BEAM takes over the MobSim, replacing the legacy MobSim engines (i.e. QSim) with the BeamMobSim. 

## Configuration File

Run the configuration file using either command prompt or the InteliJ IDE. 

https://beam.readthedocs.io/en/latest/users.html#running-beam

Copy over specification of the sf-tscore-25k.conf file to the new configuration file. Build project using InteliJ and then edit the  configuration to include the new configuration file.

The outputs will be written to the scenario/output/sf-tscore or scenario/output/slc-tscore  folder. The required files will then be copied and/or analyzed to the sf-tscore/output folder.

## Input Files ##
The basic input files necessary to run a simulation are:

- A configuration file (e.g. sf-tscore-25k.conf)
- The person population/plans and corresponding attributes files (e.g. population.xml and populationAttributes.xml)
- The household population and corresponding attributes files (e.g. households.xml and householdAttributes.xml)
- The personal vehicle fleet (e.g. vehicles.csv)
- The definition of vehicle types including for personal vehicles and the public transit fleet (e.g. vehicleTypes.csv)
- A directory containing network and transit data used by R5 (e.g. r5/)
- The open street map network (e.g. r5/sf-muni.osm)
- GTFS archives, one for each transit agency (e.g. r5/bus.zip)
- Ridehail fleet information

###1. Population or Plans File###
MATSim travel demand is described by the agents’ day plans. The full set of agents is also called the population, hence the file name population.xml. Alternatively, plans.xml is also commonly used in MATSim, as the population file essentially contains a list of day plans.

**File name:** population.xml.gz

**Fields:** Person ID, Age, Sex, Activity, Start and End coordinates, Activity end times, Activity leg

**Source for T-Score:** Output from MTC or SFCTA travel demand model.  Current thinking is to use the SF-CHAMP travel demand model outputs because they are more spatially detailed than the current MTC ActivitySim version.  
### 2. Population Attributes File
**File Name:** populationAttributes.xml.gz

**Fields:** Person ID, Household Rank, Excluded Modes, Value of Time

**Source for T-Score:** Output from MTC or SFCTA travel demand model.

### 3. Households  File
**File Name:** households.xml.gz

**Fields:** Household ID, Person ID, Vehicles, Yearly Income.

**Source for T-Score:** Output from MTC or SFCTA travel demand model.
### 4. Households Attributes File
**File Name:** householdAttributes.xml.gz

**Fields:** Household ID, Home Coordinates, Housing Type

**Source for T-Score:** Output from MTC or SFCTA travel demand model.
### 5. Vehicles File
Replacement to legacy MATSim vehicles.xml file. This must contain an Id and vehicle type for every vehicle id contained in households.xml.
**File Name:** vehicles.csv

**Fields:** Vehicle ID, Vehicle Type

**Source for T-Score:** Output from MTC or SFCTA travel demand model.Generated based on modeled vehicle ownership.

To generate automatically from population/household data, make changes to the following parameters in the common/matsim.conf file:

matsim.conversion.generateVehicles = true (If true, the conversion will use the population data to generate default vehicles, one per agent)

matsim.conversion.vehiclesFile = “Siouxfalls_vehicles.xml” (optional, if generateVehicles is false, specify the matsim vehicles file name)

### 6. Vehicle Types  File
**File Name:** vehicleTypes.csv

**Fields:** Vehicle Type ID, Seating Capacity. Standing Room Capacity, Length, Fuel Type and consumption in Joules per Meter, Maximum Velocity, Passenger Car Unit, Vehicle Category, Probability within category,

**Note:** Contains human body as a vehicle type, possibly to enable walk mode

**Source for T-Score:** : Energy modeling is not a priority, so assume a single vehicle type or defaults. 

## Network File
Contains node coordinates, link IDs, freeflow speed, capacity, number of lanes, modes allowed.

**File Name:** physsim-network.xml 

### From MATsim Network

The following MATSim input data are required to convert the MATsim network files to BEAM compatible physsim network. The config file is located in test/input/common/matsim.conf .
These files are also used in the BEAM Agent simulation.  


- **MATSim network file**: (e.g. network.xml)

- A download of **OpenStreetMap data** for a region that includes your region of interest. Should be **in pbf format**. For North American downloads: http://download.geofabrik.de/north-america.html

- **MATSim plans** (or population) file: (e.g. population.xml)

The following inputs are optional and only recommended if your MATSim scenario has a constrained vehicle stock (i.e. not every person owns a vehicle):

- **MATSim vehicle** definition (e.g. vehicles.xml)
- **Travel Analysis Zone shapefile** for the region, (e.g. as can be downloaded from https://www.census.gov/geo/maps-data/data/cbf/cbf_taz.html)

Finally, this conversion can only be done with a clone of the full BEAM repository.
### From Open Street Map Network
The Open Street Map of the required network is converted to physsim network. This file is in the r5 folder.

- **OSM file in pbf format**, the Open Street Map source data file that should be clipped to the scenario network
- **OSM Mapdb file**
- Frequency Adjustment File
- Link to Grade Percent File
- TAZ Centroids and Parking files
- **GTFS Files**
Source: OpenStreetMap

### Frequency Adjustment File
Related to transit schedules

**File name:** FrequencyAdjustment.csv

**Fields:** trip_id, start and end time, headway is seconds and exact time

**Source:** GTFS?  No adjustments? 
