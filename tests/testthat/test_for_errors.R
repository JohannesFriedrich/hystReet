test_that("get_hystreet_station_data errors on wrong input for hystreetId", {
  
  expect_error(object = get_hystreet_station_data(hystreetId = "73",
                                                  query = list(from = "foo", 
                                                               to = "bar",
                                                               resolution = "hour"),
                                                  API_token = "foo_bar"),
               regexp = "of type numeric")
  
})

#-------------------------------------------------------------------------------

test_that("get_hystreet_station_data errors on wrong input for 'from'", {
  
  expect_error(object = get_hystreet_station_data(hystreetId = 73,
                                                  query = list(from = 123, 
                                                               to = "bar",
                                                               resolution = "hour"),
                                                  API_token = "foo_bar"),
               regexp = "of type character")
  
})
