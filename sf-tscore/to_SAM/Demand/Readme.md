Contains the **plans.xml** file for each scenario to run.

Created from the SF-CHAMP output files _trip_2.dat, using script *to be added later*

#Files:

###sf-trips-except-xx.xml.gz
All trips except external-external (xx) in the San Francisco county. The trips included here have origin or destination TAZ ID <1000, i.e. these trips either begin or end within the San Francisco county.


###sf-trips-except-xx-10pc_sample.xml.gz
10 percent sample of the previous file, for experimental purpose.

###sf-trips-within.xml.gz
All trips beginning **and** ending within San Francisco county.

## XML key

Person ID: format "householdno-personid"

activity types: home, work, school, escort, business, shopping, meal and other (social recreation)

x and y coordinates: projections EPSG 26910

leg mode: 

Trip main mode type (walk, bike, drive/passenger, walk to transit, drive to transit, ride-hail, other

If dorp=1, mode was "car" for hov/sov. If dorp=2, mode was "passenger".
    