library(tidyverse)
library(sf)

tracts10 <- st_read('/Users/RASV5G/Downloads/nhgis0017_shape/nhgis0017_shapefile_tl2010_us_tract_2010/US_tract_2010.shp')

tracts10 <- tracts10 %>%
  select(fips_tract_id = GEOID10) %>%
  st_transform(5072)

aws.s3::s3saveRDS(tracts10, "s3://geomarker/geometries/tracts_2010_sf_5072.rds", multipart = TRUE)

saveRDS(tracts10, 'tracts_2010_sf_5072.rds')


dep_index18 <- 'https://github.com/geomarker-io/dep_index/raw/master/2018_dep_index/ACS_deprivation_index_by_census_tracts.rds' %>%
  url() %>%
  gzcon() %>%
  readRDS() %>%
  as_tibble()

saveRDS(dep_index18, 'tract_dep_index_2018.rds')
