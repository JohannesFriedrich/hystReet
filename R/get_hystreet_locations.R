#' Get station IDs of hystreet.com
#'
#' @param API_token Character. Key access the hystreet.com API.
#' 
#' @return A data.frame with parsed data from the hystreet.com API
#' 
#' @examples
#' \dontrun{
#'  get_hystreet_locations()
#' }
#' 
#' @export
#' 
get_hystreet_locations <- function(API_token = Sys.getenv("HYSTREET_API_TOKEN")) {
  
  res <- create_hystreet_request(endpoint = "locations",
                                 API_token = API_token)
  
  return(res$locations)

}