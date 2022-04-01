# dep_index <a href='https://degauss.org'><img src='https://github.com/degauss-org/degauss_hex_logo/raw/main/PNG/degauss_hex.png' align='right' height='138.5' /></a>

[![](https://img.shields.io/github/v/release/degauss-org/dep_index?color=469FC2&label=version&sort=semver)](https://github.com/degauss-org/dep_index/releases)
[![container build status](https://github.com/degauss-org/dep_index/workflows/build-deploy-release/badge.svg)](https://github.com/degauss-org/dep_index/actions/workflows/build-deploy-release.yaml)

## Using

If `my_address_file_geocoded.csv` is a file in the current working directory with coordinate columns named `lat` and `lon`, then the [DeGAUSS command](https://degauss.org/using_degauss.html#DeGAUSS_Commands):

```sh
docker run --rm -v $PWD:/tmp ghcr.io/degauss-org/dep_index:0.2.0 my_address_file_geocoded.csv
```

will produce `my_address_file_geocoded_dep_index_0.2.0.csv` with added columns:

- **`fips_tract_id`**: 2010 census tract identifier

- 2018 American Community Survey variables:

    + **`fraction_assisted_income`**: fraction of households receiving public assistance income or food stamps or SNAP in the past 12 months
    + **`fraction_high_school_edu`**: fraction of population 25 and older with educational attainment of at least high school graduation (includes GED equivalency)
    + **`median_income`**: median household income in the past 12 months in 2018 inflation-adjusted dollars
    + **`fraction_no_health_ins`**: fraction of poulation with no health insurance coverage
    + **`fraction_poverty`**: fraction of population with income in past 12 months below poverty level
    + **`fraction_vacant_housing`**: fraction of houses that are vacant
    
- **`dep_index`**: composite measure of the 6 variables above

## Geomarker Methods

This container overlays the input latitude and longitude coordinates with 2010 census tracts, then joins with tract-level deprivation index data derived from the 2018 American Community Survey (ACS).

For more information on the deprivation index, please see the [deprivation index page](https://geomarker.io/dep_index/).

## Geomarker Data

- 2010 tract shape files are stored at: [`s3://geomarker/geometries/tracts_2010_sf_5072.rds`](https://geomarker.s3.us-east-2.amazonaws.com/geometries/tracts_2010_sf_5072.rds).
- 2018 deprivation index data is stored at: [`s3://geomarker/tract_dep_index_2018.rds`](https://geomarker.s3.us-east-2.amazonaws.com/tract_dep_index_2018.rds) and is also available for download at [https://geomarker.io/dep_index/](https://geomarker.io/dep_index/).

## DeGAUSS Details

For detailed documentation on DeGAUSS, including general usage and installation, please see the [DeGAUSS homepage](https://degauss.org).
