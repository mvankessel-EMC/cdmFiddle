#' UI
#'
#' @import shiny
#' @export
ui <- shiny::shinyUI(
  shiny::fluidPage(
    shiny::titlePanel("CDM Fiddle"),
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::uiOutput("ace_editor"),
        shiny::actionButton("query", "Query")),
      shiny::mainPanel(
        DT::dataTableOutput(outputId = "table"))
    )
  )
)
