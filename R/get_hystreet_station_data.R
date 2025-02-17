#' Retrieve data from a specific hystreet.com station
#'
#' Fetches pedestrian count data from a specified station using the hystreet.com API.
#'
#' @param hystreetId Integer. Mandatory parameter. ID of the requested station. See `get_hystreet_locations()` for available station IDs.
#' @param query Named list of query parameters. Supported API parameters ('from', 'to', and 'resolution' are mandatory):
#' \describe{
#'   \item{\code{from}}{Character. The start date of the queried timerange. Only accepts valid RFC 3339 formatted timestamps (e.g., '2025-01-12T15:06:13+01:00'). Mandatory parameter.}
#'   \item{\code{to}}{Character. The end date of the queried timerange. Only accepts valid RFC 3339 formatted timestamps (e.g., '2025-01-22T15:06:13+01:00'). Mandatory parameter.}
#'   \item{\code{resolution}}{Character. Time resolution for measurements. Mandatory parameter. Accepts the following values: 'hour', 'day', 'week', and 'month'. Mandatory parameter.}
#'   \item{\code{include_weather_data}}{Logical. Adds data on weather conditions for every measurement if data is available. Weather information is only available with resolution set to 'hour' or 'day'.}
#'   \item{\code{include_zones}}{Logical. Some streets are split into multiple zones. This parameter ensures to split measurements in the zones of a location and return them more granularly.}
#'   \item{\code{with_measured_data_only}}{Logical. Filters the measurements to only include measurements with measured data (no modeled data). If set to false, all measurements will be returned.}
#'   \item{\code{with_object_type}}{Character. Filters the measurements by the object type. This is a main category for organizing measurements. Accepted values: 'PERSON' or 'VEHICLE'.}
#'   \item{\code{with_object_subtype}}{Character. Filters the measurements by the object subtype. This is a subcategory for organizing measurements. Accepted values: 'ADULT', 'CHILD', 'CAR', 'BUS', 'BICYCLE', or 'TRAM'. If the subtype is not related to the type, it will be ignored.}
#' }
#' @param no_metadata Logical. If `TRUE`, returns only the measurement data as a clean `data.frame`, excluding metadata. Defaults to `FALSE`.
#' @param API_token Character. API key for accessing the hystreet.com API.

#' @return A `data.frame` containing parsed data from the hystreet.com API.
#'
#' @examples
#' \dontrun{
#' # Request data for the current day from station ID 71
#' get_hystreet_station_data(71)
#'
#' # Request data for December 2018 with resolution "day"
#' get_hystreet_station_data(hystreetId = 71, 
#'                           query = list(from = "2018-12-01", 
#'                                        to = "2018-12-31", 
#'                                        resolution = "day")
#' )
#' }
#'
#' @export
#' 
get_hystreet_station_data <- function(hystreetId, 
                                      query,
                                      no_metadata = FALSE,
                                      API_token = Sys.getenv("HYSTREET_API_TOKEN")) {
  
  #-----------------------------------------------------------------------------
  # Error handling

  if (missing(hystreetId)) {
    
    stop("[get_hystreet_station_data()]: Argument 'hystreetId' has to be set.", 
         call. = FALSE)
    
  }
  
  if (missing(query)) {
    
    stop("[get_hystreet_station_data()]: Argument 'query' has to be set.", 
         call. = FALSE)
    
  }
  
  check_station_data_parameters(hystreetId = hystreetId,
                                query = query, 
                                no_metadata = no_metadata, 
                                API_token = API_token)
  
  #-----------------------------------------------------------------------------
  # Perform API request and parse data 
  
  res <- .create_hystreet_request(hystreetId = hystreetId, 
                                  query = query,
                                  API_token = API_token)
  
  if (no_metadata == TRUE) {
    
    res <- res$measurements
    res$timestamp <- .convert_dates(res$timestamp)
    
    return(res)
    
  } else {
    
    res$measurements$timestamp <- .convert_dates(res$measurements$timestamp)
    res$metadata$earliest_measurement_at <- .convert_dates(res$metadata$earliest_measurement_at)
    res$metadata$latest_measurement_at <- .convert_dates(res$metadata$latest_measurement_at)
    
    return(res)
    
  }
  
}