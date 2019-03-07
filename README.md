
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hystReet

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

## Introduction

[hystreet.com](https://hystreet.com) is a company records pedestrian counts at certain spots in
german cities. After registering and requesting access to the API you can download the data for free from
19 cities.

## Installation

Until now the package is not on CRAN but you can download it via GitHub
with the following command:

``` r
if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("JohannesFriedrich/hystReet")
```

## API Keys

To use this package, you will first need to get your hystreet API key.
To do so, go to this link: <https://hystreet.com/>

Now you have three options:

1)  
Once you have your key, save it as an environment variable for the
current session by running the following:

``` r
Sys.setenv(HYSTREET_API_TOKEN = "PASTE YOUR API TOKEN HERE")
```

2)  Alternatively, you can set it permanently with the help of
    `usethis::edit_r_environ()` by adding the line to your `.Renviron`:

<!-- end list -->

    HYSTREET_API_TOKEN = PASTE YOUR API TOKEN HERE

3)  If you don’t want to save it here, you can input it in each function
    using the `API_token`
parameter.

## Usage

| Function name                  | Description                                          | Example                          |
| ------------------------------ | ---------------------------------------------------- | -------------------------------- |
| get\_hystreet\_stats()         | request common statistics about the hystreet project | get\_hystreet\_stats()           |
| get\_hystreet\_locations()     | request all qvailable locations                      | get\_hystreet\_locations()       |
| get\_hystreet\_station\_data() | request data from a stations                         | get\_hystreet\_station\_data(71) |
| set\_hystreet\_token()         | set your API token                                   | set\_hystreet\_token(123456789)  |

### Load some statistics

The function ‘get\_hystreet\_stats()’ summarises the number of available
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

counts

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

55

</td>

<td style="text-align:right;">

352970219

</td>

</tr>

</tbody>

</table>

### Request all stations

The function ‘get\_hystreet\_locations()’ requests all available
stations of the project.

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

53

</td>

<td style="text-align:left;">

Schadowstraße (West)

</td>

<td style="text-align:left;">

Düsseldorf

</td>

</tr>

<tr>

<td style="text-align:right;">

114

</td>

<td style="text-align:left;">

Herrenteichsstraße (Ost)

</td>

<td style="text-align:left;">

Osnabrück

</td>

</tr>

<tr>

<td style="text-align:right;">

94

</td>

<td style="text-align:left;">

Kurfürstendamm Südseite (Ost)

</td>

<td style="text-align:left;">

Berlin

</td>

</tr>

<tr>

<td style="text-align:right;">

103

</td>

<td style="text-align:left;">

Schuchardstraße

</td>

<td style="text-align:left;">

Darmstadt

</td>

</tr>

<tr>

<td style="text-align:right;">

108

</td>

<td style="text-align:left;">

Große Straße (Mitte)

</td>

<td style="text-align:left;">

Osnabrück

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

95

</td>

<td style="text-align:left;">

Planken (Mitte)

</td>

<td style="text-align:left;">

Mannheim

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

54

</td>

<td style="text-align:left;">

Schadowstraße (Ost)

</td>

<td style="text-align:left;">

Düsseldorf

</td>

</tr>

<tr>

<td style="text-align:right;">

109

</td>

<td style="text-align:left;">

Krahnstraße (Mitte, Altstadt)

</td>

<td style="text-align:left;">

Osnabrück

</td>

</tr>

</tbody>

</table>

### Request data from a specific station

The (properly) most interesting function is
‘get\_hystreet\_station\_data()’. With the hystreetID it is possible
to request a specific station. By default, all the data from the current
day are received. With the ‘query’ argument it is possible to set the
received data more precise: \* from: datetime of earliest measurement
(default: today 00:00:00:): e.g. “10-01-2018 12:00:00” or “2018-10-01”
\* to : datetime of latest measurement (default: today 23:59:59): e.g.
“12-01-2018 12:00:00” or “2018-12-01” \* resoution: Resultion for the
measurement grouping (default: hour): “day”, “hour”, “month”, “week”

``` r
data <- get_hystreet_station_data(
  hystreetId = 71, 
  query = list(from = "01-12-2018", to = "31-12-2018", resolution = "day"))
```

## Some ideas to visualise the data

Let´s see if we can see the most frequent days before christmas … I
think it could be saturday ;-). Also nice to see the 24th and 25th of
December … holidays in Germany :-).

``` r
data <- get_hystreet_station_data(
    hystreetId = 71, 
    query = list(from = "01-12-2018", to = "01-01-2019"))
```

``` r
ggplot(data$measurements, aes(x = timestamp, y = pedestrians_count, colour = weekdays(timestamp))) +
  geom_path(group = 1) +
  scale_x_datetime(date_breaks = "7 days") +
  labs(x = "Date",
       y = "Pedestrians",
       colour = "Day")
```

<img src="README_figs/README-unnamed-chunk-12-1.png" width="672" style="display: block; margin: auto;" />

Now let´s compare different stations:

1)  Load the data

<!-- end list -->

``` r
data_73 <- get_hystreet_station_data(
    hystreetId = 73, 
    query = list(from = "01-01-2019", to = "31-01-2019", resolution = "day"))$measurements %>% 
  select(1:2) %>% 
  mutate(station = 73)

data_74 <- get_hystreet_station_data(
    hystreetId = 74, 
    query = list(from = "01-01-2019", to = "31-01-2019", resolution = "day"))$measurements %>% 
    select(1:2) %>% 
  mutate(station = 74)

data <- bind_rows(data_73, data_74)
```

``` r
ggplot(data, aes(x = timestamp, y = pedestrians_count, fill = weekdays(timestamp))) +
  geom_bar(stat = "identity") +
  scale_x_datetime(labels = date_format("%d.%m.%Y")) +
  facet_wrap(~station, scales = "free_y") +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 45, hjust = 1))
```

<img src="README_figs/README-unnamed-chunk-14-1.png" width="672" style="display: block; margin: auto;" />

Now a little bit of big data analysis. Let´s find the station with the
highest pedestrians per day ratio:

``` r
hystreet_ids <- get_hystreet_locations()

all_data <- lapply(hystreet_ids[,"id"], function(x){
  temp <- get_hystreet_station_data(
    hystreetId = x)
  
  
    lifetime_count <- temp$statistics$lifetime_count
    days_counted <- as.numeric(temp$metadata$latest_measurement_at  - temp$metadata$earliest_measurement_at)
    
    return(data.frame(
      id = x,
      station = paste0(temp$city, " (",temp$name,")"),
      ratio = lifetime_count/days_counted))
  
})

ratio <- bind_rows(all_data)
```

What stations have the highest ratio?

``` r
ratio %>% 
  top_n(5, ratio) %>% 
  arrange(desc(ratio))
##   id                         station    ratio
## 1 73      München (Neuhauser Straße) 86538.62
## 2 47     Köln (Schildergasse (West)) 63698.54
## 3 63          Hannover (Georgstraße) 62319.37
## 4 77 Stuttgart (Königstraße (Mitte)) 52406.47
## 5 48      Köln (Hohe Straße (Mitte)) 48382.38
```

Now let´s visualise the top 10 cities:

``` r
ggplot(ratio %>% 
         top_n(10,ratio), aes(station, ratio)) +
  geom_bar(stat = "identity") +
  labs(x = "City",
       y = "Pedestrians per day") + 
    theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 45, hjust = 1))
```

<img src="README_figs/README-unnamed-chunk-17-1.png" width="672" style="display: block; margin: auto;" />
