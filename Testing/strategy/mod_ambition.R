#' ambition UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_ambition_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' ambition Server Functions
#'
#' @noRd 
mod_ambition <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_ambition_ui("ambition_ui_1")
    
## To be copied in the server
# mod_ambition_server("ambition_ui_1")
