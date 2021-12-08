#' main UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList plotOutput
#' @importFrom shinipsum random_DT
#' 
mod_main_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("random_plot"))
  )
}
    
#' main Server Functions
#'
#' @importFrom shiny moduleServer renderPlot
#' @importFrom shinipsum random_ggplot
#' @noRd 
mod_main_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    output$random_plot <- renderPlot(
      random_ggplot()
    )
 
  })
}
    
## To be copied in the UI
# mod_main_ui("main_ui_1")
    
## To be copied in the server
# mod_main_server("main_ui_1")
