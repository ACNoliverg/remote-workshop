#' ambition UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList DTOutput plotlyOutput
mod_ambition_ui <- function(id){
  ns <- NS(id)
  tagList(
    semanticPage(
      split_layout(DT::DTOutput(ns("ui_input")),
                   plotlyOutput(ns("ui_output"))
                   )
      )
    )
}
#' ambition Server Functions
#' 
#' @importFrom shiny renderDT renderPlotly
#' @importFrom shinipsum random_DT random_plotly
#'
#' @noRd 
mod_ambition <- function(id){
  moduleServer( id, function(input, output, session){
    #ns <- session$ns
    
    output$ui_input <- renderDT({
        shinipsum::random_DT(ncol = 4, nrow = 6)
        })
    output$ui_output <- renderPlotly({
      shinipsum::random_plotly()
    })
    
  })
}
    
## To be copied in the UI
# mod_ambition_ui("ambition_ui_1")
    
## To be copied in the server
# mod_ambition_server("ambition_ui_1")
