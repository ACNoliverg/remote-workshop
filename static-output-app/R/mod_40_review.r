#' 02_context UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_02_context_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' 02_context Server Functions
#'
#' @noRd 
mod_02_context_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_02_context_ui("02_context_ui_1")
    
## To be copied in the server
# mod_02_context_server("02_context_ui_1")
