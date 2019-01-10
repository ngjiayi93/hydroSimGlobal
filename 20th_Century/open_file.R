
# The data are saved in a list of 1,593 elements, each one corresponding to a different reservoir.
# Data were obtained via simulation on the period January 1906 -- December 2000.
# For further details, see Ng, J.Y., Turner, S.W.D., Galelli, S. (2017) Influence of El Nino 
# Southern Oscillation of global hydropower production. Environmental Research Letters, 12, 034010.
#
# For most reservoirs, technical specifications were extracted from GRanD Database 
# Refer to http://www.gwsp.org/products/grand-database.html
# Hydropower reservoirs with ID greater than 10000 are not in the GRanD Database.


# Load data
load("Results_20th_cen.RData")

# Visualise the attributes of each element (reservoir). (In this example, we visualise the attributes of
# the first reservoir.)
attributes(Results_20th_cen[[1]])

# The attributes are:
#1. GRAND_ID
#2. DAM_NAME
#3. LONG_DD: Longitude
#4. LAT_DD: Latitude
#5. inflow_MCM: inflow into reservoir (million cubic meter per month), obtained from WATCH database. Monthly time series (January 1906 -- December 2000).
#6. storage_MCM: reservoir storage at start of the month (MCM), obtained via simulation. Monthly time series (January 1906 -- December 2000).
#7. releases_MCM: release from reservoir (MCM per month), obtained via simulation. Monthly time series (January 1906 -- December 2000).
#8. evap_loss_MCM: evaporation loss from reservoir (MCM per month), obtained via simulation. Monthly time series (January 1906 -- December 2000).
#9. water_level_M: water level of reservoir at start of the month (M), obtained via simulation. Monthly time series (January 1906 -- December 2000).
#10. spill_MCM: spill from reservoir (MCM per month), obtained via simulation. Monthly time series (January 1906 -- December 2000).
#11. power_MW: average hydropower (MW), obtained via simulation. Monthly time series (January 1906 -- December 2000).
#12. flow_disc: inflow discretization bounding quantiles (used for the design of operating rules via Stochastic Dynamic Programming)
#13. energy_MWh: total hydropower energy produced from 1906-2000, obtained via simulation. 

# Plot average hydropower (MW) for the first reservoir
plot(Results_20th_cen[[1]]$power_MW,ylab="hydropower [MW]")

# Create and save a data.frame of average hydropower (MW). Each column represents a different dam, while
# each row corresponds to a month.
hydropower <- matrix(ncol = 1593, nrow = 1140)
grand_id <- c()
for (i in 1:1593){
  hydropower[,i] <- Results_20th_cen[[i]]$power_MW
  grand_id <- c(grand_id, Results_20th_cen[[i]]$GRAND_ID)
}
months <- seq(as.Date("1906/1/1"), by = "month", length.out = 1140)
months <- format(months, "%Y-%b")
hydropower <- as.data.frame(hydropower, row.names = months)
colnames(hydropower) <- grand_id
write.csv(hydropower, file = "power_MW.csv")

# For more information on the simulation approach, please refer to the R package "reservoir"
install.packages("reservoir")
?reservoir
?sdp_hydro














