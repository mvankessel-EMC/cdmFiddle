#' server
#'
#' @param input input from ui
#' @param output output to ui
#' @param session session object of client
#' @import DatabaseConnector glue shinyAce
#' @importFrom shiny renderUI reactive eventReactive isolate
#' @importFrom DT renderDataTable datatable
#' @export
#' @examples
#' \dontrun{
#' shiny::shinyApp(server = server, ui = ui)
#' }

source("global.R")

server <- function(input, output, session) {
  connection <- connectToDb()
  message("Connected to Eunomia SQLite database")

  # Get schema of Eunomia
  getSchema <- shiny::reactive({
    schemaData <- DatabaseConnector::renderTranslateQuerySql(
      get("connection", envir = e),
      "SELECT lower(name) schema FROM sqlite_schema WHERE type='table' ORDER BY name;")
    return(schemaData$SCHEMA)
  })

  # Check SQL input
  checkQuery <- shiny::reactive({
    if(!endsWith(input$editor, ";")) {
      sql <- glue::glue(input$editor, ";")
    } else {
      sql <- input$editor
    }
  })

  # Get data
  getData <- shiny::eventReactive(input$query, {
    data <- DatabaseConnector::renderTranslateQuerySql(
      connection = get("connection", envir = e),
      sql = checkQuery(), errorReportFile = "")

    DT::datatable(data, options = list(scrollX = TRUE))
  })

  # Update table with result
  output$table <- shiny::isolate(DT::renderDataTable({
    getData()}))

  # Autocompletion stuff
  comps <- shiny::reactive({
    comps <- list()
    temp <- getSchema()
    comps <- c(comps, list(Eunomia = temp))
    # print(comps)
    comps <- c(comps, sapply(temp, getCols, get("connection", envir = e)))
    # print(comps)
  })

  # Setup Ace
  output$ace_editor <- shiny::renderUI({
    shinyAce::aceEditor(
      "editor",
      mode = "sql",
      value = "SELECT * FROM person",
      autoComplete = "live",
      autoCompleters = "static",
      autoCompleteList = shiny::isolate(comps()))
  })

  shiny::onStop(function() {
    DatabaseConnector::disconnect(get("connection", envir = e))
    #rm(list = c("e", "getCols"))
    rm(list = c("e", "getCols"), envir = .GlobalEnv)
  })
}
