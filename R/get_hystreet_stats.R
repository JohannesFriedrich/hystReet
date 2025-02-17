#' Get statistics from the hystreet.com via hystreet.com's API
#'
#' @param verbose [logical] (**optional**): Show more verbose output? Defaults to FALSE.
#' @param API_token [character] (**optional**): API key to get access to hystreet.com API
#' 
#' @return A [data.frame] with parsed data from hystreet.com API
#'
#' @examples 
#' \dontrun{
#'  get_hystreet_stats(TRUE)
#' }
#' @export
#' 
get_hystreet_stats <- function(verbose = FALSE, 
                               API_token = NULL) {
  
  res <- .create_hystreet_request(API_token)
  
  if (verbose) {
    
    return(res)
    
  } else {
    
    stats <- data.frame(stations = nrow(res),
                        today_count = sum(res$statistics$today_count))
   
    return(stats)
    
  }
  
}