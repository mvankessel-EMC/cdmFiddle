#' UI
#'
#' @importFrom shiny shinyUI fluidPage titlePanel sidebarLayout sidebarPanel
#' actionButton mainPanel
#' @importFrom DT DTOutput
#' @export
ui <- shiny::shinyUI(
  shiny::fluidPage(
    shiny::titlePanel("CDM Fiddle"),
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::uiOutput("ace_editor"),
        shiny::actionButton("query", "Query")),
      shiny::mainPanel(
        DT::DTOutput(outputId = "table"))
    )
  )
)
