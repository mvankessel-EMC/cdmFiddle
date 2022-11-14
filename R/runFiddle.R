#' runFiddle
#'
#' @import shiny
#' @export

runFiddle <- function() {
  appDir <- system.file(package = "cdmFiddle", "shinyApp")
  if (appDir == "") {
    stop("Could not find shiny application")
  } else {
    shiny::shinyAppDir(appDir)
  }
}
