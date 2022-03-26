## file to create datasets for vignette

library(hystReet)
library(dplyr)

locations <- get_hystreet_locations()

save(locations, file = "data/locations.RData")

## ------------------------------

location_71 <- get_hystreet_station_data(
  hystreetId = 71, 
  query = list(from = "2021-12-01", to = "2022-01-01", resolution = "hour"))

save(location_71, file = "data/location_71.RData")

## ------------------------------

location_73 <- get_hystreet_station_data(
  hystreetId = 73, 
  query = list(from = "2022-01-01", to = "2022-01-31", resolution = "day"))$measurements %>% 
  select(pedestrians_count, timestamp) %>% 
  mutate(station = 73)

location_74 <- get_hystreet_station_data(
  hystreetId = 74, 
  query = list(from = "2022-01-01", to = "2022-01-31", resolution = "day"))$measurements %>% 
  select(pedestrians_count, timestamp) %>% 
  mutate(station = 74)

data_73_74 <- bind_rows(location_73, location_74)

save(data_73_74, file = "data/data_73_74.RData")

## ------------------------------

hystreet_ids <- get_hystreet_locations()

all_data <- lapply(hystreet_ids[,"id"], function(ID){
  temp <- get_hystreet_station_data(
    hystreetId = ID,
    query = list(from = "2021-01-01", to = "2021-12-31", resolution = "day"))
  
  lifetime_count <- temp$statistics$timerange_count
  days_counted <- as.integer(ymd(temp$metadata$measured_to)  - ymd(temp$metadata$measured_from))
  
  return(data.frame(
    id = ID,
    station = paste0(temp$city, " (",temp$name,")"),
    ratio = lifetime_count/days_counted))
  
})

ratio <- bind_rows(all_data)

save(ratio, file = "data/ratio.RData")

## ------------------------------

corona_data <- lapply(hystreet_ids[,"id"], function(ID){
  
  temp <- get_hystreet_station_data(
    hystreetId = ID,
    query = list(from = "2020-03-01", to = "2020-06-10", resolution = "day")
  )
  
  return(data.frame(
    name = temp$name,
    city = temp$city,
    timestamp = format(as.POSIXct(temp$measurements$timestamp), "%Y-%m-%d"),
    pedestrians_count = temp$measurements$pedestrians_count,
    legend = paste(temp$city, temp$name, sep = " - ")
  ))
  
}) 

corona_data_all <- bind_rows(data)

save(corona_data_all, file = "data/corona_data_all.RData")

## ------------------------------


