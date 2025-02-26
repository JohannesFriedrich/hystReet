#' Create HTTP request to hystreet.com API
#'
#' @param hystreetId Integer. ID of a hystreet.com location
#' @param query List. Query parameters to get data for specific date. 
#' @param API_token Character. API token to get access to hystreet.com API
#'
#' @return A data.frame with parsed data from hystreet.com API
#'
.create_hystreet_request <- function(endpoint,
                                     hystreetId = NULL,
                                     query = NULL,
                                     API_token) {
  
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
  
  if (httr::http_error(res)) {
    
    content <- httr::content(res, "parsed", encoding = "UTF-8")
    
    if ("message" %in% names(content)) {
        
      warning(content$message, call. = FALSE)
      
    } else {
        
      httr::message_for_status(res)
        
    }
    
    return(NULL)
    
  } else {
    
    content <- httr::content(res, "text")
    
    parsed_request <- jsonlite::fromJSON(content)
    
    return(parsed_request)
    
  }
  
}