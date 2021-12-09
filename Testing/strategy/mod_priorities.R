#' priorities UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_priorities_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' priorities Server Functions
#'
#' @noRd 
mod_priorities_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_priorities_ui("priorities_ui_1")
    
## To be copied in the server
# mod_priorities_server("priorities_ui_1")
