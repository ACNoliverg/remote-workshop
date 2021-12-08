#' 1100_initiate_databases UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_1100_initiate_databases_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' 1100_initiate_databases Server Functions
#'
#' @importFrom shiny moduleServer
#'
#' @noRd
mod_1100_initiate_databases_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_1100_initiate_databases_ui("1100_initiate_databases_ui_1")
    
## To be copied in the server
# mod_1100_initiate_databases_server("1100_initiate_databases_ui_1")
