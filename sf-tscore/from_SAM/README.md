These files will be output from the transit optimization:

### Transit Schedule

transit_schedule.xml is the main file we will pass back and forth showing the fixed route transit schedule.  We will only change SFMTA bus, and leave everything else constant.  

SF.zip is a GTFS file for the SFMTA transit. Currently, the GTFS files are provided for information, and the transit_schedule.xml file is from a different city (so it won't work, and it just there to show the format). We will get this cleaned up on the BEAM end. 

### On-Demand Transit

We talked through a few options, and this may require more thought.  We could: 

1. Write out an on-demand microtransit fleet in the same format as the ride-hail fleet.  This simply gives the start location, shift hours and geofence for each vehicle.  Essentially it would be a very high level specification of how a transit operator should manage the fleet, and leave the matching up to BEAM.  This means it would likely differ between BEAM and the optimization, but that may be OK.  If we do this, the optimization would write a file that looks like onDemandTransitFleet.csv

2. Write indvidual on-demand microtransit trips as if they were a fixed-route schedule.  

3. Write these as plans.xml file and force BEAM to hold those plans fixed.  

