#' timeframe UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_timeframe_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' timeframe Server Functions
#'
#' @noRd 
mod_timeframe_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_timeframe_ui("timeframe_ui_1")
    
## To be copied in the server
# mod_timeframe_server("timeframe_ui_1")
