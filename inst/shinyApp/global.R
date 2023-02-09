#' getCols
#'
#' @param table table name in database
#' @param connection connection object
getCols <- function(table, connection) {
  tolower(DatabaseConnector::renderTranslateQuerySql(
    connection,
    paste0("PRAGMA table_info(", table, ")"))$NAME)
}

#' connectToDb
#'
#' @return DatabaseConnector connection object
#'
#' @import DatabaseConnector
#' @import Eunomia
connectToDb <- function() {
  connectionDetails = Eunomia::getEunomiaConnectionDetails()
  connection <- DatabaseConnector::connect(connectionDetails)
  return(connection)
}
