#' server
#'
#' @param input input from ui
#' @param output output to ui
#' @param session session object of client
#' @import DatabaseConnector
#' @import shinyAce
#' @import shiny

source("global.R")

server <- function(input, output, session) {
  connection <- connectToDb()
  message("Connected to Eunomia SQLite database")

  # Get schema of Eunomia
  getSchema <- shiny::reactive({
    schemaData <- DatabaseConnector::renderTranslateQuerySql(
      connection = connection,
      sql = "SELECT lower(name) schema
      FROM sqlite_schema
      WHERE type='table'
      ORDER BY name;")
    return(schemaData$SCHEMA)
  })

  # Check SQL input
  checkQuery <- shiny::reactive({
    if(!endsWith(input$editor, ";")) {
      sql <- paste0(input$editor, ";")
    } else {
      sql <- input$editor
    }
  })

  # Get data
  getData <- shiny::eventReactive(input$query, {
    data <- DatabaseConnector::renderTranslateQuerySql(
      connection = connection,
      sql = checkQuery(),
      errorReportFile = "")

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

    comps <- c(
      comps,
      sapply(
        X = temp,
        FUN = getCols,
        connection = connection))
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
    DatabaseConnector::disconnect(connection = connection)
    #DatabaseConnector::disconnect(get("connection", envir = e))
    rm(list = c("connectToDb", "getCols"), envir = .GlobalEnv)
  })
}
