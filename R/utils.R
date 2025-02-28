#' Convert date into YMD-HMS format
#'
#' @param date Date to be converted
#'
#' @returns Converted date
#'
.convert_dates <- function(date) {
  
  return(lubridate::ymd_hms(date, tz = "Europe/Berlin", quiet = TRUE))  
  
}

#-------------------------------------------------------------------------------

#' Check parameter values for errors
#'
#' @param hystreetId Parameter to be checked
#' @param query Parameter to be checked
#' @param no_metadata Parameter to be checked
#' @param API_token Parameter to be checked
#'
check_station_data_parameters <- function(hystreetId,
                                          query,
                                          no_metadata,
                                          API_token) {
  
  if (length(hystreetId) != 1 || !is.numeric(hystreetId)) {
    
    stop("Argument 'hystreetId' has to be of type numeric and of length 1.", 
         call. = FALSE)
    
  }
  
  if (!inherits(query, "list")) {
    
    stop("Argument 'query' has to be a list.", 
         call. = FALSE)
    
  }
  
  if (!is.logical(no_metadata)) {
    
    stop("Parameter 'no_metadata' has to be logical (TRUE or FALSE).", 
         call. = FALSE)
    
  }
  
  if (!all(c("from", "to", "resolution") %in% names(query))) {
    
    stop("Named list parameter 'query' has to contain parameters 'from', 'to' and 'resolution'.",
         call. = FALSE)
    
  }
  
  if (length(query$from) != 1 || !is.character(query$from)) {
    
    stop("Parameter 'from' has to be of length 1 and of type character.",
         call. = FALSE)
    
  }
  
  if (length(query$to) != 1 || !is.character(query$to)) {
    
    stop("Parameter 'to' has to be of length 1 and of type character.",
         call. = FALSE)
    
  }
  
  if (!(query$resolution %in% c("hour", "day", "week", "month")) || 
      length(query$resolution) > 1 || 
      !is.character(query$resolution)) {
    
    stop("Parameter 'resolution' has to be of length 1, of type character and accepts only the following values: 'hour', 'day', 'week', 'month'.", 
         call. = FALSE)
    
  }
  
  valid_api_token(API_token)
  
}

#-------------------------------------------------------------------------------

#' Check validity of API token
#'
#' @param API_token Token to be checked
#'
valid_api_token <- function(API_token) {
  
  if (length(API_token) != 1 || !is.character(API_token)) {
    
    stop("Argument 'API_token' has to be of type character and of length 1.", 
         call. = FALSE)
    
  }
  
  if (API_token == "") {
    
    stop("You have to give your API key as function argument or set a HYSTREET_API_TOKEN environment variable.\n",
         call. = FALSE)
    
  }
  
}

#-------------------------------------------------------------------------------

#' Parse query parameter list
#'
#' @param query Named query parameter list
#'
#' @returns Parsed query list
#'
parse_parameter_values <- function(query) {
  
  if ("include_weather_data" %in% names(query)) {
    
    if (!is.logical(query$include_weather_data) || 
        length(query$include_weather_data) != 1) {
      
      stop("Parameter 'include_weather_data' has to be of type logical and of length 1.",
           call. = FALSE)
      
    }
    
    if (query$resolution %in% c("week", "month") & 
        isTRUE(query$include_weather_data)) {
      
      stop("Including weather data only applicable if 'resolution' is 'hour' or 'day'.",
           call. = FALSE)
      
    }
    
    query$include_weather_data <- ifelse(isTRUE(query$include_weather_data), 
                                         "true", 
                                         "false")
    
  }
  
  #-----------------------------------------------------------------------------
  
  if ("include_zones" %in% names(query)) {
    
    if (!is.logical(query$include_zones) || 
        length(query$include_zones) != 1) {
      
      stop("Parameter 'include_zones' has to be of type logical and of length 1.",
           call. = FALSE)
      
    }
    
    query$include_zones <- ifelse(isTRUE(query$include_zones), 
                                         "true", 
                                         "false")
    
  }
  
  #-----------------------------------------------------------------------------
  
  if ("with_measured_data_only" %in% names(query)) {
    
    if (!is.logical(query$with_measured_data_only) || 
        length(query$with_measured_data_only) != 1) {
      
      stop("Parameter 'with_measured_data_only' has to be of type logical and of length 1.",
           call. = FALSE)
      
    }
    
    query$with_measured_data_only <- ifelse(isTRUE(query$with_measured_data_only), 
                                         "true", 
                                         "false")
    
  }
  
  return(query)
  
}
