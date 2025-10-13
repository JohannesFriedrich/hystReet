#' Read downloaded data from the hystreet.com web page to data.frames
#'
#' @param path Character. (**Required**): Path to the downloaded CSV file.
#' @param ... **Optional**: Arguments passed to 'utils::read.csv2()'
#' 
#' @return A data.frame with parsed data from the hystreet.com API
#'
#' @examples 
#' \dontrun{
#' df <- hystReet::read_hystreet_csv("~/Downloads/hystreet.csv")
#'  }
#' @export
#' 
read_hystreet_csv <- function(path, ...) {

  data <- read.csv2(path, ...)
  
  return(data)

}