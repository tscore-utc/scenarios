# Scenario Descriptions #

There is one folder for each scenario.  

### Base Scenario with 25k Population

This is starting from the sf-lite scenario that comes with BEAM.  It will eventually be replaced with a more complete SF scenario. 

# Core Files #

These are the main inputs provided from BEAM to the transit optimization.    They are broken into core files and extra files.  For each of the MATSim files, the first line of the file links to the file specification.  

### Road Network ###
output_network.xml is the road network file in MATSim format. It includes the geometry of the network, link capacities, etc. This will (I think!) not change between iterations. 

### Link Stats ###
30.linkstats.csv or 30.linkstats.txt.  These files include traffic volumes and congested travel times by hour of the day.  30 represents the BEAM iteration number.  These files will be updated each time BEAM is run. 

### Transit Schedule ###
transit_schedule.xml is the main file we will pass back and forth showing the fixed route transit schedule.  

SF.zip is a GTFS file for the SFMTA transit.  BA.zip is a GTFS file for other Bay Area transit operators (BART, Caltrain, GGT, SamTrans and AC Transit also serve SF, but these will be internal-external trips) and won't change in our simulation.  

Note that BEAM currently reads the GTFS files as input then converts to MATSIM/BEAM format.  We want to run this conversion only once, and pass the transit_schedule.xml file back and forth.  Currently, the GTFS files are provided for information, and the transit_schedule.xml file is from a different city (so it won't work, and it just there to show the format). We will get this cleaned up on the BEAM end. 

### Output Plans ###
output_plans.xml is the output from the BEAM simulation.  It includes each person in the simulation, their sequence of activities and travel, the coordinates of start/end of each trip, departure/arrival times, and the chosen mode. 

# Extra Files #

The extra files are provided for informational purposes, but may not be necessary to run the optimization.  

### Events ###
30.events.xml - This file gets huge, and shows every event in the simulation.  It is also available in CSV format if that is easier to process.  It is useful for tabulation results, and may or may not be necessary for the optimization.  
