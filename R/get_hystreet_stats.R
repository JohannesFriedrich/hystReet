#' Get statistics from the Hystreet Project via Hystreet API
#'
#' @param verbose [logical] (**optional**): Show more verbose output?
#' @param API_token [character] (**optional**): API key to get access to Hystreet API
#' 
#' @return [data.frame] with parsed data from hystreet API
#'
#' @section Function version 0.0.1
#' @author Johannes Friedrich
#' 
#' @examples 
#' 
#'  hystreet_stats <- get_hystreet_stats(TRUE)
#'
#' @md
#' @export

get_hystreet_stats <- function(verbose = FALSE, API_token = NULL){
  
  
  res <- .create_hystreet_request(API_token)
  
  if(verbose){
    
    stats <- data.frame(
      id = res$id,
      name = res$name,
      city = res$city, 
      lifetime_counts = res$statistics$lifetime_count,
      earliest_measurement = res$metadata$earliest_measurement_at,
      latest_measurement = res$metadata$latest_measurement_at)
    
  } else {
    
    stats <- data.frame(
      stations = nrow(res),
      counts = sum(res$statistics$lifetime_count)
    )
    
  }
  
  return(stats)
  
}