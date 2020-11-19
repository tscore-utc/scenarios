# T-Score Scenarios
The MMOS half of the T-SCORE UTC revolves around applying and adapting a multi-agent 
simulation and an multi-modal optimization algorithm to examine the potential 
consequences of ride-hail and on-demand transit policies in multiple cities. This
repository contains the data necessary to run these scenarios, as well as 
provide a template for applications in other places.

The MMOS scenarios are developed for two metropolitan regions:

  - San Francisco County, California
  - Wasatch Front region (Salt Lake City and environs), Utah


## Project Navigation


## Handoff Strategy
This section describes the specifics of how the two different halves of the MMOS 
project interact. This was originally described in the proposal with a version of
the following graphic:

![MMOS Diagram](https://i.imgur.com/bF8vrpm.png)

The details are as follows:

  1. Scenario-specific plans and network files are developed as inputs to 
     the BEAM multi-agent transportation simulation. 
  2. The BEAM mode choice model
     and transit / ride hail dispatcher provide an estimate of which individuals
     are likely to use each service, adapted from the initial choice supplied by 
     the activity-based models.
        - An initial guess as to the location and fleet size of ridehail and 
          microtransit vehicles will be necessary.
        - On-demand microtransit will be represented as a pooled ridehail option. 
          This means that the existing BEAM ridehail manager may need modest changes to represent
          lower fares or more restrictive geofencing.
  3. BEAM output files for highway and transit networks are provided as inputs to the 
     multi-modal optimization program (SAM?). Also supplied is the
     the BEAM output plans file, with which mode each individual used for each trip.
  4. SAM will generate a new fixed-route transit network and a list of ridehail and on-demand
     transit requests.
        - We will need to develop a strategy to convert these request frequencies and 
          locations into a fleet design, which will feed back into step 2.
          
Both halves of the model will use the same mode choice model utility functions.
