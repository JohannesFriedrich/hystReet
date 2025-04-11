#' Retrieve details for a specific hystreet.com station
#'
#' @param hystreetId Integer. Mandatory parameter. ID of the requested station. See `get_hystreet_locations()` for available station IDs.
#' @param API_token Character. API key for accessing the hystreet.com API.
#'
#' @description Detailled information in form of a named list includes, e.g., postal code, time of earliest and latest measurement and information on the sensor and the zones.
#'
#' @returns A list with detailled information on the station
#' 
#' @examples
#' \dontrun{
#' get_hystreet_location_details(148)
#' }
#' 
#' @export
#' 
get_hystreet_location_details <- function(hystreetId,
                                          API_token = Sys.getenv("HYSTREET_API_TOKEN")) {
  
  if (!is.numeric(hystreetId) || length(hystreetId) != 1) {
    
    stop("Parameter 'hystreetId' has to be of type numeric and of length 1.",
         call. = FALSE)
    
  }
  
  res <- create_hystreet_request(endpoint = "details",
                                 hystreetId = hystreetId, 
                                 API_token = API_token)
  
  return(res)
  
}