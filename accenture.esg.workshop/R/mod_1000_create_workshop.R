#' 1000_create_workshop UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList
mod_1000_create_workshop_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' 1000_create_workshop Server Functions
#'
#' @noRd 
#' @importFrom shiny moduleServer
mod_1000_create_workshop_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_1000_create_workshop_ui("1000_create_workshop_ui_1")
    
## To be copied in the server
# mod_1000_create_workshop_server("1000_create_workshop_ui_1")
