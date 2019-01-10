# The data are saved in a list of 1,593 elements, each one corresponding to a different reservoir.
# Data were obtained via simulation on the period January 2001 -- December 2100
#   using 3 GCMs (CNRM, ECHAM, IPSL) and 2 emission scenarios (IPCC SRES A2 and B1)
# For further details, see Turner, S. W., Ng, J. Y., & Galelli, S. (2017). Examining global 
#   electricity supply vulnerability to climate change using a high-fidelity hydropower dam 
#   model. Science of the Total Environment, 590, 663-675.
#
# For most reservoirs, technical specifications were extracted from GRanD Database 
# Refer to http://www.gwsp.org/products/grand-database.html
# Hydropower reservoirs with ID greater than 10000 are not in the GRanD Database.

# Load data
load("Results_21st_CNRM.RData") #results for the GCM CNRM

# Visualise the attributes of each element (reservoir). (In this example, we visualise the attributes of
# the first reservoir.)
attributes(Results_21st_CNRM[[1]])

# The attributes are:
#1. GRAND_ID
#2. DAM_NAME
#3. LONG_DD: Longitude
#4. LAT_DD: Latitude
#5. a2: Results for A2 emission scenario
#6. b1: Results for B1 emission scenario

attributes(Results_21st_CNRM[[1]]$a2)
# For each emission scenario, the following results are available:
#1. inflow_MCM: inflow into reservoir (million cubic meter per month), obtained from WATCH database. Monthly time series (January 1965 -- December 2100).
#2. storage_MCM: reservoir storage at start of the month (MCM), obtained via simulation. Monthly time series (January 2001 -- December 2100).
#3. releases_MCM: release from reservoir (MCM per month), obtained via simulation. Monthly time series (January 2001 -- December 2100).
#4. evap_loss_MCM: evaporation loss from reservoir (MCM per month), obtained via simulation. Monthly time series (January 2001 -- December 21000).
#5. water_level_M: water level of reservoir at start of the month (M), obtained via simulation. Monthly time series (January 2001 -- December 2100).
#6. spill_MCM: spill from reservoir (MCM per month), obtained via simulation. Monthly time series (January 2001 -- December 2100).
#7. power_MW: average hydropower (MW), obtained via simulation. Monthly time series (January 2001 -- December 2100).
#8. flow_disc: inflow discretization bounding quantiles (used for the design of operating rules via Stochastic Dynamic Programming)
#9. energy_MWh: total hydropower energy produced from 2001-2100, obtained via simulation. 

# Plot average hydropower (MW) for the first reservoir
plot(Results_21st_CNRM[[1]]$a2$power_MW,ylab="hydropower [MW]")

# Create and save a data.frame of average hydropower (MW). Each column represents a different dam, while
# each row corresponds to a month.
hydropower <- matrix(ncol = 1593, nrow = 1200)
grand_id <- c()
for (i in 1:1593){
  hydropower[,i] <- Results_21st_CNRM[[i]]$a2$power_MW
  grand_id <- c(grand_id, Results_21st_CNRM[[i]]$GRAND_ID)
}
months <- seq(as.Date("2001/1/1"), by = "month", length.out = 1200)
months <- format(months, "%Y-%b")
hydropower <- as.data.frame(hydropower, row.names = months)
colnames(hydropower) <- grand_id
write.csv(hydropower, file = "power_MW.csv")

# For more information on the simulation approach, please refer to the R package "reservoir"
install.packages("reservoir")
?reservoir
?sdp_hydro
