# dep_index <a href='https://degauss-org.github.io/DeGAUSS/'><img src='DeGAUSS_hex.png' align='right' height='138.5' /></a>

> DeGAUSS container that adds census tract deprivation index to [geocoded](https://degauss.org/geocoder) addresses

[![Docker Build Status](https://img.shields.io/docker/automated/degauss/dep_index)](https://hub.docker.com/repository/docker/degauss/dep_index/tags)
[![GitHub Latest Tag](https://img.shields.io/github/v/tag/degauss-org/dep_index)](https://github.com/degauss-org/dep_index/releases)

## DeGAUSS example call

If `my_address_file_geocoded.csv` is a file in the current working directory with coordinate columns named `lat` and `lon`, then

```sh
docker run --rm -v $PWD:/tmp degauss/dep_index:0.1 my_address_file_geocoded.csv
```

will produce `my_address_file_geocoded_dep_index_v0.1.csv` with added columns named `fips_tract_id`, `fraction_assisted_income`,	`fraction_high_school_edu`,	`median_income`,	`fraction_no_health_ins`,	`fraction_poverty`,	`fraction_vacant_housing`, and `dep_index`.

## Deprivation Index details

This container overlays the input latitude and longitude coordinates with 2010 census tracts, then joins with tract-level deprivation index data derived from the 2018 American Community Survey (ACS).

For more information on the deprivation index, please see the [deprivation index page](https://geomarker.io/dep_index)

## DeGAUSS details

For detailed documentation on DeGAUSS, including general usage and installation, please see the [DeGAUSS homepage](https://degauss.org).
