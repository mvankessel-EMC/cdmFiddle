#' getCols
#'
#' @param table table name in database
#' @param connection connection object
#'
#' @import DatabaseConnector glue
getCols <- function(table, connection) {
  tolower(DatabaseConnector::renderTranslateQuerySql(
    connection,
    glue::glue("PRAGMA table_info(", table, ")"))$NAME)
}

#' connectToDb
#'
#' @return DatabaseConnector connection object
#'
#' @import DatabaseConnector
connectToDb <- function(
    connectionDetails = Eunomia::getEunomiaConnectionDetails(),
    schema = "main") {
  e <<- new.env()
  e$connection <- DatabaseConnector::connect(connectionDetails)
  e$schema <- schema
}
