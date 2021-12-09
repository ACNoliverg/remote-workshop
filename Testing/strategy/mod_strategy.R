#' strategy UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList  tabPanel navbarPage
#' @import shiny.semantic
mod_strategy_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::navbarPage("nabvbar!",
               shiny::tabPanel("Ambition",
                        mod_ambition_ui("ambition")
                        ),
               shiny:tabPanel("Prorities",
                              mod_priorities_ui("priorities")),
               shiny::tabPanel("Timeframes",
                               mod_timeframe_ui("timeframe"))
               )
  )
}
    
#' strategy Server Functions
#'
#' @noRd 
#' 
mod_strategy <- function(id){
  #ns <- session$
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    mod_ambition_ui("ambition_ui_1")
    mod_ambition_ui("priorities_ui_1")
    mod_ambition_ui("timeframe_ui_1")
  })
}
    
## To be copied in the UI
# mod_strategy_ui("strategy_ui_1")
    
## To be copied in the server
# mod_strategy_server("strategy_ui_1")
