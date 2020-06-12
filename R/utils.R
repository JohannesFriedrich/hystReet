## utils

.convert_dates <- function(date){
  
  return(lubridate::ymd_hms(date, tz = "Europe/Amsterdam", quiet = TRUE))  
  
}