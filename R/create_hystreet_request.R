#' Create request to Hystreet API
#'
#' @param API_key [character]: API key to get access to Hystreet API
#' @param hystreetId [integer]: Id of a hystreet location
#' @param query [list]: Querys to get data for specific date. Use with argument path = c("from", "to", "resolution").
#'
#' @return [data.frame] with parsed data from hystreet API
#'
#' @section Function version 0.0.1
#' @author Johannes Friedrich
#'
#' @keywords internal 
.create_hystreet_request <- function(
  API_key = NULL,
  hystreetId = NULL,
  query = NULL){
  
  ##=======================================##
  ## ERROR HANDLING
  ##=======================================##
  
  if (!is.null(query) && class(query) != "list")
    stop("[create_hystreet_request()] Argument 'query' has to be a list", call. = FALSE)
  
  ##=======================================##
  ## TRY TO GET API KEY FROM ENVIRONMENT
  ##=======================================##
  
  if(is.null(API_key)){
    
    hystreet_token <- .get_hystreet_token()
    
  } else {
    
    hystreet_token <- API_key
    
  }
  
  ##=======================================##
  ## Let´S GETTED STARTED
  ##=======================================##
  
  host <- "https://hystreet.com/api/locations"
  header_type <- "application/vnd.hystreet.v1" 
  
  url <- httr::modify_url(host, path = c("api", "locations", hystreetId))
  
  res <- GET(url,
             query = query,
             add_headers(
               "x-api-token" = hystreet_token, 
                Accept = header_type))
  
  if (httr::http_error(res)) {
    content <-  httr::content(res, 'parsed', encoding = 'UTF-8')
    warning(
      if ('message' %in% names(content)) {
        content$message
      } else {
        paste0("Errorcode: ", httr::status_code(res), ".\n")
      }, call. = FALSE)
    
    return(NULL)
  } else {
    
    content <- httr::content(res, "text")
    
    parsed_request <- jsonlite::fromJSON(content)
    
    return(parsed_request)
  }
}