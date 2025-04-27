with_mock_dir("raw_data_list_output", {

  test_that("the station data are delivered as a list", {

    skip_on_cran()
    skip_on_ci()
    
    res <- get_hystreet_station_data(hystreetId = 148,
                                     query = list(from = "2025-02-20T15:00:00+01:00",
                                                  to = "2025-02-20T18:00:00+01:00",
                                                  resolution = "hour",
                                                  include_weather_data = TRUE,
                                                  include_zones = TRUE,
                                                  with_object_type = "PERSON",
                                                  with_object_subtype = "CHILD",
                                                  with_measured_data_only = FALSE))
    
    # Tests
    expect_true(is.list(res))
    expect_true("weather_conditions" %in% names(res$measurements))
    expect_true("zone" %in% names(res$measurements$counts[[1]]))
    expect_true(res$resolution == "hour")
    
  })
  
})

#-------------------------------------------------------------------------------

with_mock_dir("get_hystreet_stats", {
  
  test_that("get_hystreet_stats returns as expected", {
    
    skip_on_cran()
    skip_on_ci()
    
    res <- get_hystreet_location_details(hystreetId = 148)
    
    # Tests
    expect_true(is.list(res))
    expect_true("id" %in% names(res$location))
    expect_true("city" %in% names(res$location))
    
  })
  
})

#-------------------------------------------------------------------------------

with_mock_dir("get_hystreet_locations", {
  
  test_that("get_hystreet_locations returns as expected", {
    
    skip_on_cran()
    skip_on_ci()
    
    res <- get_hystreet_locations()
    
    # Tests
    expect_s3_class(object = res, class = "data.frame")
    expect_true("id" %in% names(res))
    expect_true("city" %in% names(res))
    
  })
  
})
