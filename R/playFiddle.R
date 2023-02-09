#' playFiddle
#'
#' @import shiny
#' @import shinyAce
#' @import Eunomia
#' @import DatabaseConnector
#' @importFrom data.table data.table
#'
#' @export
playFiddle <- function() {
  appDir <- system.file(package = "cdmFiddle", "shinyApp")
  if (appDir == "") {
    stop("Could not find shiny application")
  } else {
    shiny::shinyAppDir(appDir)
  }
}
