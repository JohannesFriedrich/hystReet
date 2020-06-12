
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hystReet

[![CRAN](http://www.r-pkg.org/badges/version/hystReet)](https://CRAN.R-project.org/package=hystReet)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/hystReet)](https://www.r-pkg.org/pkg/hystReet)
[![Build
Status](https://travis-ci.org/JohannesFriedrich/hystReet.svg?branch=master)](https://travis-ci.org/JohannesFriedrich/hystReet)
[![Build
status](https://ci.appveyor.com/api/projects/status/hfno1wngf2yqs4e9?svg=true)](https://ci.appveyor.com/project/JohannesFriedrich/hystreet)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

## Introduction

[hystreet](https://hystreet.com) is a company that collects data on
pedestrian traffic in shopping streets of different German cities. After
registering you can access and download the data via their website.

## Installation

Until now the package is not on CRAN but you can install it from GitHub
with the following command:

``` r
if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("JohannesFriedrich/hystReet")
```

## API Keys

To use this package, you will first need to get a hystreet API key. To
do so, you first need to set up an account on <https://hystreet.com/>.
After that you can request an API key via
[e-mail](mailto:info@hystreet.com). Once your request has been granted,
you will find you key in your hystreet account profile.

Now you have three options:

1)  Once you have your key, you can save it as an environment variable
    for the current session by running the following command:

<!-- end list -->

``` r
Sys.setenv(HYSTREET_API_TOKEN = "PASTE YOUR API TOKEN HERE")
```

2)  Alternatively, you can set it permanently with the help of
    `usethis::edit_r_environ()` by adding the following line to your
    `.Renviron`:

<!-- end list -->

    HYSTREET_API_TOKEN = PASTE YOUR API TOKEN HERE

3)  If you don’t want to save your API token here, you can enter it for
    each function of this package using the `API_token`
parameter.

## Usage

| Function name                  | Description                                          | Example                          |
| ------------------------------ | ---------------------------------------------------- | -------------------------------- |
| get\_hystreet\_stats()         | request common statistics about the hystreet project | get\_hystreet\_stats()           |
| get\_hystreet\_locations()     | request all available locations                      | get\_hystreet\_locations()       |
| get\_hystreet\_station\_data() | request data from a stations                         | get\_hystreet\_station\_data(71) |
| set\_hystreet\_token()         | set your API token                                   | set\_hystreet\_token(123456789)  |

### Load some statistics

The function `get_hystreet_stats()` summarises the number of available
stations and the sum of all counted pedestrians.

``` r
library(hystReet)
## Loading required package: httr
## Loading required package: jsonlite
## 
## Attaching package: 'jsonlite'
## The following object is masked from 'package:purrr':
## 
##     flatten

stats <- get_hystreet_stats()
```

``` r
stats
```

<table>

<thead>

<tr>

<th style="text-align:right;">

stations

</th>

<th style="text-align:right;">

today\_count

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

127

</td>

<td style="text-align:right;">

347781

</td>

</tr>

</tbody>

</table>

### Request all stations

The function `get_hystreet_locations()` generates a data frame with all
available stations of the project.

``` r
locations <- get_hystreet_locations()
```

``` r
locations
```

<table>

<thead>

<tr>

<th style="text-align:right;">

id

</th>

<th style="text-align:left;">

name

</th>

<th style="text-align:left;">

city

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

59

</td>

<td style="text-align:left;">

Goethestraße

</td>

<td style="text-align:left;">

Frankfurt a.M.

</td>

</tr>

<tr>

<td style="text-align:right;">

57

</td>

<td style="text-align:left;">

Schlösserstraße

</td>

<td style="text-align:left;">

Erfurt

</td>

</tr>

<tr>

<td style="text-align:right;">

68

</td>

<td style="text-align:left;">

Petersstraße

</td>

<td style="text-align:left;">

Leipzig

</td>

</tr>

<tr>

<td style="text-align:right;">

256

</td>

<td style="text-align:left;">

Kirchgasse (Nord)

</td>

<td style="text-align:left;">

Wiesbaden

</td>

</tr>

<tr>

<td style="text-align:right;">

86

</td>

<td style="text-align:left;">

Löhrstraße (Mitte)

</td>

<td style="text-align:left;">

Koblenz

</td>

</tr>

<tr>

<td style="text-align:right;">

107

</td>

<td style="text-align:left;">

Krahnstraße (Süd)

</td>

<td style="text-align:left;">

Osnabrück

</td>

</tr>

<tr>

<td style="text-align:right;">

206

</td>

<td style="text-align:left;">

Kröpeliner Straße (West)

</td>

<td style="text-align:left;">

Rostock

</td>

</tr>

<tr>

<td style="text-align:right;">

77

</td>

<td style="text-align:left;">

Königstraße (Süd)

</td>

<td style="text-align:left;">

Stuttgart

</td>

</tr>

<tr>

<td style="text-align:right;">

150

</td>

<td style="text-align:left;">

Zeil (Mitte)

</td>

<td style="text-align:left;">

Frankfurt a.M.

</td>

</tr>

<tr>

<td style="text-align:right;">

53

</td>

<td style="text-align:left;">

Schadowstraße (West)

</td>

<td style="text-align:left;">

Düsseldorf

</td>

</tr>

</tbody>

</table>

### Request data from a specific station

The (probably) most interesting function is
`get_hystreet_station_data()`. Using the hystreetID it is possible to
request a specific station. By default, all the data from the current
day are received. With the `query` argument it is possible to define the
time and sampling frame of the data more precisely: `from`: datetime of
earliest measurement (default: today 00:00:00:): e.g. “2018-10-01
12:00:00” or “2018-10-01” `to` : datetime of latest measurement
(default: today 23:59:59): e.g. “2018-12-01 12:00:00” or “2018-12-01”
`resoution`: Resultion for the measurement (default: hour): “day”,
“hour”, “month”, “week”

``` r
data <- get_hystreet_station_data(
  hystreetId = 71,
  query = list(from = "2018-12-01", to = "2018-12-31", resolution = "day"))
```

## Some ideas for visualising the data

Let´s see if we can find the busiest days in December 2018. Saturdays
were probably quite busy, while there should have been substantially
less pedestrian traffic on the 24th and 25th of December, both of which
are holidays in Germany.

``` r
data <- get_hystreet_station_data(
    hystreetId = 71, 
    query = list(from = "2018-12-01", to = "2019-01-01", resolution = "hour"))
```

``` r
ggplot(data$measurements, aes(x = timestamp, y = pedestrians_count, colour = weekdays(timestamp))) +
  geom_path(group = 1) +
  scale_x_datetime(date_breaks = "7 days") +
  scale_x_datetime(labels = date_format("%d.%m.%Y")) +
  labs(x = "Date",
       y = "Pedestrians",
       colour = "Day")
## Scale for 'x' is already present. Adding another scale for 'x', which will
## replace the existing scale.
```

<img src="README_figs/README-station_71-1.png" width="672" style="display: block; margin: auto;" />

### Compare different stations

Now let´s compare data from different stations:

1)  Load the data

<!-- end list -->

``` r
data_73 <- get_hystreet_station_data(
    hystreetId = 73, 
    query = list(from = "2019-01-01", to = "2019-01-31", resolution = "day"))$measurements %>% 
  select(pedestrians_count, timestamp) %>% 
  mutate(station = 73)

data_74 <- get_hystreet_station_data(
    hystreetId = 74, 
    query = list(from = "2019-01-01", to = "2019-01-31", resolution = "day"))$measurements %>% 
    select(pedestrians_count, timestamp) %>% 
  mutate(station = 74)

data_73_74 <- bind_rows(data_73, data_74)
```

``` r
ggplot(data_73_74, aes(x = timestamp, y = pedestrians_count, fill = weekdays(timestamp))) +
  geom_bar(stat = "identity") +
  scale_x_datetime(labels = date_format("%d.%m.%Y")) +
  facet_wrap(~station, scales = "free_y") +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 45, hjust = 1))
```

<img src="README_figs/README-station_73_74-1.png" width="672" style="display: block; margin: auto;" />

### Highest ratio (pedestrians/day)

Now a little bit of big data analysis. Let´s find the station with the
highest pedestrians per day ratio:

``` r
hystreet_ids <- get_hystreet_locations()

all_data <- lapply(hystreet_ids[,"id"], function(ID){
  temp <- get_hystreet_station_data(
    hystreetId = ID,
    query = list(from = "2019-01-01", to = today(), resolution = "day"))
  
  
    lifetime_count <- temp$statistics$timerange_count
    days_counted <- as.numeric(temp$metadata$latest_measurement_at  - temp$metadata$earliest_measurement_at)
    
    return(data.frame(
      id = ID,
      station = paste0(temp$city, " (",temp$name,")"),
      ratio = lifetime_count/days_counted))
  
})

ratio <- bind_rows(all_data)
```

Which stations have the highest ratio?

``` r
ratio %>% 
  top_n(5, ratio) %>% 
  arrange(desc(ratio))
##    id                       station    ratio
## 1 165     München (Kaufingerstraße) 64462.33
## 2 150 Frankfurt a.M. (Zeil (Mitte)) 52516.24
## 3 159  Köln (Schildergasse (Mitte)) 50313.61
## 4  73    München (Neuhauser Straße) 49994.01
## 5 158      Köln (Hohe Straße (Süd)) 39803.41
```

Now let´s visualise the top 10 locations:

``` r
ggplot(ratio %>% 
         top_n(10,ratio), aes(station, ratio)) +
  geom_bar(stat = "identity") +
  labs(x = "Location",
       y = "Pedestrians per day") + 
    theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 45, hjust = 1))
```

<img src="README_figs/README-ratio_plot-1.png" width="672" style="display: block; margin: auto;" />

### Corona effects

The Hystreet-API is a great source of analysing the social effects of
the Corona pandemic in 2020. Let´s collect all german stations since
March 2020 and analyse the pedestrian count until 10th June 2020.

``` r
data <- lapply(hystreet_ids[,"id"], function(ID){

    temp <- get_hystreet_station_data(
        hystreetId = ID,
        query = list(from = "2020-03-01", to = "2020-06-10", resolution = "day")
    )
    
    return(data.frame(
    name = temp$name,
    city = temp$city,
    timestamp = format(as.POSIXct(temp$measurements$timestamp), "%Y-%m-%d"),
    pedestrians_count = temp$measurements$pedestrians_count,
    legend = paste(temp$city, temp$name, sep = " - ")
  ))
   
}) 

data_all <- bind_rows(data)
```

``` r
data_all %>% 
ggplot(aes(ymd(timestamp), pedestrians_count, colour = legend)) +
geom_line(alpha = 0.2) +
    scale_x_date(labels = date_format("%d.%m.%Y"),
               breaks = date_breaks("7 days")
     ) +
  theme(legend.position = "none",
        legend.title = element_text("Legende"),
         axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "Date",
       y = "Persons/Day")
```

<img src="README_figs/README-corona_effects_plot-1.png" width="672" style="display: block; margin: auto;" />
