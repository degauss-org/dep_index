#!/usr/local/bin/Rscript

dht::greeting(geomarker_name = 'dep_index', version = '0.1', description = 'adds tract-level deprivation index to geocoded data')

dht::qlibrary(dht)
qlibrary(dplyr)
qlibrary(tidyr)
qlibrary(sf)

doc <- '
      Usage:
      dep_index.R <filename>
      '

opt <- docopt::docopt(doc)
## for interactive testing
## opt <- docopt::docopt(doc, args = 'test/my_address_file_geocoded.csv')

cli::cli_alert_info('reading input file...')
d <- dht::read_lat_lon_csv(opt$filename, nest_df = T, sf = T, project_to_crs = 5072)

dht::check_for_column(d$raw_data, 'lat', d$raw_data$lat)
dht::check_for_column(d$raw_data, 'lat', d$raw_data$lat)

cli::cli_alert_info('reading tract shapefile...')
tracts10 <- readRDS('/opt/tracts_2010_sf_5072.rds')
# tracts10 <- readRDS('tracts_2010_sf_5072.rds')

cli::cli_alert_info('joining to 2010 TIGER/Line+ census tracts using EPSG:5072 projection')
d_tract <- st_join(d$d, tracts10) %>%
   st_drop_geometry()

cli::cli_alert_info('reading deprivation index data...')
dep_index18 <- readRDS('/opt/tract_dep_index_18.rds')
# dep_index18 <- readRDS('tract_dep_index_2018.rds')

cli::cli_alert_info('joining 2018 tract-level deprivation index')
d_tract <- left_join(d_tract, dep_index18, by = c('fips_tract_id' = 'census_tract_fips'))


## merge back on .row after unnesting .rows into .row
dht::write_geomarker_file(d = d_tract,
                     raw_data = d$raw_data,
                     filename = opt$filename,
                     geomarker_name = 'dep_index',
                     version = '0.1')
