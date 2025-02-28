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
                                                  with_measured_data_only = FALSE))
    
    expect_true(is.list(res))
    
  })
  
})