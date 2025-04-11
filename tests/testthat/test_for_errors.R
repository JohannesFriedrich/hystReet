#-------------------------------------------------------------------------------
# Unit tests for errors and warnings
#-------------------------------------------------------------------------------

test_that("get_hystreet_station_data errors for 'hystreetId'", {
  
  expect_error(object = get_hystreet_station_data(hystreetId = "148",
                                                  query = list(from = "foo", 
                                                               to = "bar",
                                                               resolution = "hour"),
                                                  API_token = "foo_bar"),
               regexp = "of type numeric")
  
  expect_error(object = get_hystreet_station_data(query = list(from = "foo", 
                                                               to = "bar",
                                                               resolution = "hour"),
                                                  API_token = "foo_bar"),
               regexp = "Argument 'hystreetId' has to be set")
  
})

#-------------------------------------------------------------------------------

test_that("get_hystreet_station_data errors for 'from'", {
  
  expect_error(object = get_hystreet_station_data(hystreetId = 73,
                                                  query = list(from = 123, 
                                                               to = "foo",
                                                               resolution = "hour"),
                                                  API_token = "foo_bar"),
               regexp = "of type character")
  
})

#-------------------------------------------------------------------------------

test_that("get_hystreet_station_data errors for 'to'", {
  
  expect_error(object = get_hystreet_station_data(hystreetId = 73,
                                                  query = list(from = "foo", 
                                                               to = 123,
                                                               resolution = "hour"),
                                                  API_token = "foo_bar"),
               regexp = "of type character")
  
})

#-------------------------------------------------------------------------------

test_that("get_hystreet_station_data errors for 'resolution'", {
  
  expect_error(object = get_hystreet_station_data(hystreetId = 73,
                                                  query = list(from = "foo", 
                                                               to = "bar",
                                                               resolution = "stunde"),
                                                  API_token = "foo_bar"),
               regexp = "Parameter 'resolution' has to be of length 1")
  
})

#-------------------------------------------------------------------------------

test_that("get_hystreet_location_details errors for 'hystreetId'", {
  
  expect_error(object = get_hystreet_location_details(hystreetId = "73",
                                                      API_token = "foo_bar"),
               regexp = "Parameter 'hystreetId' has to be of type numeric and of length 1.")
  
})
