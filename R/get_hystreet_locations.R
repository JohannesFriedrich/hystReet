#' Get station IDs of the Hystreet project
#'
#' @param API_token [character] (**optional**): API key to get access to Hystreet API
#' 
#' @return [data.frame] with parsed data from hystreet API
#'
#' @section Function version 0.0.1
#' @author Johannes Friedrich
#' 
#' @examples
#' \dontrun{
#'  all_hystreet_IDs <- get_hystreet_locations()
#' }
#' @md
#' @export

get_hystreet_locations <- function(API_token = NULL){
  
  
  res <- .create_hystreet_request(API_token)
  
  return(res[,1:3])

}