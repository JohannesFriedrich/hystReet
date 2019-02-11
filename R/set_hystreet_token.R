#' Create request to Hystreet API
#'
#' @param API_token [character] (**required**): API key to get access to Hystreet API
#' 
#' @return Set environment variable
#'
#' @section Function version 0.0.1
#' @author Johannes Friedrich
#'
#' @md
#' @export

set_hystreet_token <- function(API_token = NULL) {
  
  if(is.null(API_token)){
    stop("Please set env var HYSTREET_API_TOKEN to your hystreet API personal access token",
         call. = FALSE)}
  
  Sys.setenv(HYSTREET_API_TOKEN = API_token)
  
}

# function to return hystreet API key stored in the HYSTREET_API_KEY environment variable
.get_hystreet_token <- function() {
  hystreet_token <- Sys.getenv("HYSTREET_API_TOKEN")
  if (hystreet_token == "") {
    stop("[hystReet] You have given your API key as function argument or set a HYSTREET_API_TOKEN environment variable.\n",
         call. = FALSE)
  }
  return(hystreet_token)
}