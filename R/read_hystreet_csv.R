#' Read downloaded data from the hystreet webpage to  data.frames
#'
#' @param path [string] (**required**): path to the downloaded csv file
#' @param ... (**optional**): arguments passed to [utils::read.csv2()]
#' 
#' @return [data.frame] with parsed data from hystreet API
#'
#' @section Function version:
#' 0.0.1
#' @author Johannes Friedrich
#' 
#' @examples 
#' \dontrun{
#' ## read data from downlaoded csv file data
#' df <- hystReet::read_hystreet_csv("~/Downloads/hystreet.csv")
#' 
#'  }
#' @md
#' @export

read_hystreet_csv <- function(path, ...){

  data <- read.csv2(path, ...)
  
  return(data)

}