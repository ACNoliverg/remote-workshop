#' new_mod UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_new_mod_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' new_mod Server Functions
#'
#' @noRd 
mod_new_mod_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_new_mod_ui("new_mod_ui_1")
    
## To be copied in the server
# mod_new_mod_server("new_mod_ui_1")
