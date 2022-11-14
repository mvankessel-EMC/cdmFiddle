
# cdmFiddle

---

The goal of cdmFiddle is to to provide an interactive interface with the OMOP 
CDM through a Shiny application.

The entire application runs in RAM, including the [Eunomia](https://github.com/OHDSI/Eunomia) database on SQLite.

All queries are executed through
[`DatabaseConnector::renderTranslateQuerySql`](https://github.com/OHDSI/DatabaseConnector). 
and are therefore translated to the SQLite dialect. This is mostly important 
when working with dates, as SQLite has very limited date(time) functionality. 
Things like `SELECT TOP 10 * FORM person` should however 'just work'.


## Features
- Interactive interface with a locally run OMOP CDM database
- Auto completion for OMOP CDM tables and columns
- Translation to SQLite dialect
- ANSI SQL highlighting
- Interactive sorting, and searching on the current query result


## Installation

You can install the development version of cdmFiddle like so:

``` r
install.packages("remotes")
remotes::install_github("cdmFiddle")
```

## Example

Run the Shiny application

``` r
library(cdmFiddle)
cdmFiddle::runFiddle()
```

