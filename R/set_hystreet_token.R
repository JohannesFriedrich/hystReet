#' Set your API token for the hystreet.com API
#'
#' @param API_token Character. API key to get access to hystreet.com API.
#' 
#' @return Environment variable set to the API token
#'
set_hystreet_token <- function(API_token) {
  
  valid_api_token(API_token)
  
  Sys.setenv(HYSTREET_API_TOKEN = API_token)
  
}