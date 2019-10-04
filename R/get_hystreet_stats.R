#' Get statistics from the Hystreet Project via Hystreet API
#'
#' @param verbose [logical] (**optional**): Show more verbose output?
#' @param API_token [character] (**optional**): API key to get access to Hystreet API
#' 
#' @return [data.frame] with parsed data from hystreet API
#'
#' @section Function version 0.0.2
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
    
    return(res)
    
  } else {
    
    stats <- data.frame(
      stations = nrow(res),
      today_count = sum(res$statistics$today_count)
    )
   
    return(stats) 
    
  }
  
}