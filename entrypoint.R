#!/usr/local/bin/Rscript

dht::greeting()

## load libraries without messages or warnings
withr::with_message_sink("/dev/null", library(dplyr))
withr::with_message_sink("/dev/null", library(tidyr))
withr::with_message_sink("/dev/null", library(sf))

doc <- "
      Usage:
      entrypoint.R <filename>
      "

opt <- docopt::docopt(doc)

## for interactive testing
## opt <- docopt::docopt(doc, args = 'test/my_address_file_geocoded.csv')
## opt <- docopt::docopt(doc, args = 'my_address_file_geocoded.csv')

message("reading input file...")
d <- dht::read_lat_lon_csv(opt$filename, nest_df = T, sf = T, project_to_crs = 5072)

dht::check_for_column(d$raw_data, "lat", d$raw_data$lat)
dht::check_for_column(d$raw_data, "lon", d$raw_data$lon)

## add code here to calculate geomarkers
message("reading tract shapefile...")
tracts10 <- readRDS('/opt/tracts_2010_sf_5072.rds')

message("joining to 2010 TIGER/Line+ census tracts using EPSG:5072 projection")
d_tract <- st_join(d$d, tracts10) %>%
  st_drop_geometry()

message("reading deprivation index data...")
dep_index18 <- readRDS('/opt/tract_dep_index_18.rds')

message("joining 2018 tract-level deprivation index")
d_tract <- left_join(d_tract, dep_index18, by = c('fips_tract_id' = 'census_tract_fips'))
d_tract <- rename(d_tract, census_tract_id = fips_tract_id)

## merge back on .row after unnesting .rows into .row
dht::write_geomarker_file(d = d_tract,
                          raw_data = d$raw_data,
                          filename = opt$filename)
