#' runFiddle
#'
#' @import shiny
#' @import shinyAce
#' @import DT
#' @import Eunomia
#' @import DatabaseConnector
#' @export

runFiddle <- function() {
  appDir <- system.file(package = "cdmFiddle", "shinyApp")
  if (appDir == "") {
    stop("Could not find shiny application")
  } else {
    shiny::shinyAppDir(appDir)
  }
}
