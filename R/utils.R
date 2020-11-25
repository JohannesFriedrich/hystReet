## utils

.convert_dates <- function(date){
  
  return(lubridate::ymd_hms(date, tz = "Europe/Berlin", quiet = TRUE))  
  
}