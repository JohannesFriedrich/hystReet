#' Create HTTP request to the hystreet.com API
#'
#' @param endpoint Character. Endpoint to send the request to.
#' @param hystreetId Integer. ID of a hystreet.com location.
#' @param query List. Query parameters to get data for specific date. 
#' @param API_token Character. API key for accessing the hystreet.com API.
#'
#' @return A data.frame with parsed data from the hystreet.com API.
#'
create_hystreet_request <- function(endpoint,
                                    hystreetId = NULL,
                                    query = NULL,
                                    API_token) {
  
  #-------------------------------------------------------------------------------
  # Check API token
  valid_api_token(API_token = API_token)
  
  #-----------------------------------------------------------------------------
  # Create and perform HTTP call to hystreet.com API

  host <- "https://api.hystreet.com/"
  header_type <- "application/json" 

  if (endpoint == "locations") {
  
    url <- httr::modify_url(host, path = c("v2", "locations"))
  
  } else if (endpoint == "measurements") {
    
    url <- httr::modify_url(host, path = c("v2", "locations", hystreetId, "measurements"))
    
  } else if (endpoint == "details") {
    
    url <- httr::modify_url(host, path = c("v2", "locations", hystreetId))
    
  }
  
  res <- httr::GET(url,
                   query = query,
                   add_headers("x-api-token" = API_token, 
                               Accept = header_type))
  
  #-------------------------------------------------------------------------------
  # Parsing of results
  
  if (httr::status_code(res) == 204) {
    
    stop("Your request has not returned any results. Check your parameter settings.",
         call. = FALSE)
    
  }
  
  if (httr::http_error(res)) {

    content <- httr::content(res, "parsed", encoding = "UTF-8")

    if ("message" %in% names(content)) {

      warning(content$message, call. = FALSE)

    } else {

      httr::message_for_status(res)

    }

  } else {

    content <- httr::content(res, "text")

    parsed_request <- jsonlite::fromJSON(content)

    return(parsed_request)

  }
  
}