#' Retrieve data from a specific hystreet.com station
#'
#' @description This function fetches pedestrian count data from a specified station using the hystreet.com API. It is the main powerhouse of the package.
#'
#' @param hystreetId Integer. Mandatory parameter. ID of the requested station. See `get_hystreet_locations()` for available station IDs.
#' @param query Named list of query parameters. Supported API parameters ('from', 'to', and 'resolution' are mandatory):
#' \describe{
#'   \item{\code{from}}{Character. The start date of the queried timerange. Only accepts valid RFC 3339 formatted timestamps (e.g., '2025-01-12T15:06:13+01:00'). Mandatory parameter.}
#'   \item{\code{to}}{Character. The end date of the queried timerange. Only accepts valid RFC 3339 formatted timestamps (e.g., '2025-01-22T15:06:13+01:00'). Mandatory parameter.}
#'   \item{\code{resolution}}{Character. Time resolution for measurements. Accepts the following values: 'hour', 'day', 'week', and 'month'. Mandatory parameter.}
#'   \item{\code{include_weather_data}}{Logical. Adds data on weather conditions for every measurement if data is available. Weather information is only available with resolution set to 'hour' or 'day'.}
#'   \item{\code{include_zones}}{Logical. Some streets are split into multiple zones. This parameter ensures to split measurements in the zones of a location and return them more granularly.}
#'   \item{\code{with_measured_data_only}}{Logical. Filters the measurements to only include measurements with measured data (no modeled data). If set to FALSE, all measurements will be returned.}
#' }
#' @param no_metadata Logical. If `TRUE`, returns only the measurement data as a clean `data.frame`, excluding metadata. Defaults to `FALSE`.
#' @param API_token Character. API key for accessing the hystreet.com API.
#' 
#' @details Note: Due to performance reasons, the maximum date range for the 'from' and 'to' parameters is limited to 366 days. Use 'from' and 'to' to fetch data in smaller chunks.
#' 
#' @return A nested list with the query results. If 'no_metadata' is set to TRUE: A `data.frame` containing parsed data from the hystreet.com API with only the raw counts and the timestamp.
#'
#' @examples
#' \dontrun{
#' # Request data with resolution "hour"
#' res <- get_hystreet_station_data(hystreetId = 148,
#'                                  query = list(from = "2025-02-20T15:00:00+01:00",
#'                                               to = "2025-02-25T18:00:00+01:00",
#'                                               resolution = "hour",
#'                                               include_weather_data = TRUE,
#'                                               include_zones = TRUE,
#'                                               with_measured_data_only = FALSE))
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
    
    stop("Argument 'hystreetId' has to be set.", 
         call. = FALSE)
    
  }
  
  if (missing(query)) {
    
    stop("Argument 'query' has to be set.", 
         call. = FALSE)
    
  }
  
  # Validity checks on API parameter values
  check_station_data_parameters(hystreetId = hystreetId,
                                query = query, 
                                no_metadata = no_metadata)
  
  #-------------------------------------------------------------------------------
  # Parse parameters to match API requirements + validity checks
  query <- parse_parameter_values(query)

  #-----------------------------------------------------------------------------
  # Perform API request and parse data 
  res <- create_hystreet_request(endpoint = "measurements",
                                 hystreetId = hystreetId, 
                                 query = query,
                                 API_token = API_token)
  
  if (no_metadata == TRUE) {
    
    res <- res$measurements[, 1:3]
    res$measured_at <- convert_dates(res$measured_at)
    res$measured_at_local_time <- convert_dates(res$measured_at_local_time)
    
    return(res)
    
  } else {
    
    res$measurement_period$from <- convert_dates(res$measurement_period$from)
    res$measurement_period$to <- convert_dates(res$measurement_period$to)
    res$measurements$measured_at <- convert_dates(res$measurements$measured_at)
    res$measurements$measured_at_local_time <- convert_dates(res$measurements$measured_at_local_time)
    
    return(res)
    
  }
  
}