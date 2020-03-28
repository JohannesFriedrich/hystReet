#' hystReet
#'
#' An R API wrapper for the hystreet project. 
#' Download and analyse environmental data provided by https://hystreet.com/
#'
#' \tabular{ll}{Package: \tab hystReet \cr Type: \tab Package \cr Version:
#' \tab 0.0.1 \cr Date: \tab 2020-03-28 \cr License: \tab GPL-2 \cr }
#'
#' @name hystReet-package
#'
#' @docType package
#'
#' @keywords package
#' @import httr jsonlite lubridate
NULL

#' Downloaded data for the vignette
#'
#' @format [data.frame] with pedestrians counta from January 2019
#' @docType data
#' @author Johannes Friedrich
#' @name data
NULL

#' Downloaded data for the vignette
#'
#' @format [list] with results from location 71 in december 2018
#' @docType data
#' @author Johannes Friedrich
#' @name location_71
NULL

#' Downloaded data for the vignette
#'
#' @format [data.frame] with all available locaations (03/27/2020)
#' @docType data
#' @author Johannes Friedrich
#' @name locations
NULL

#' Downloaded data for the vignette
#'
#' @format [data.frame] with pedestrians counta/day
#' @docType data
#' @author Johannes Friedrich
#' @name ratio
NULL