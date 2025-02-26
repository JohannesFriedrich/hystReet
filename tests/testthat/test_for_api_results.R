
# loc <- get_hystreet_locations()

res <- get_hystreet_station_data(hystreetId = 148,
                                 query = list(from = "2025-02-22T15:00:00+01:00",
                                              to = "2025-02-22T18:00:00+01:00",
                                              resolution = "hour",
                                              include_weather_data = "true"))


# TRUE and FALSE have to be mapped to "true" and "false"
# object_type and object_subtype not working yet