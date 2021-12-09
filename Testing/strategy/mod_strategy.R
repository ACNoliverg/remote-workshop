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
    uiOutput("")
  )
}
    
#' strategy Server Functions
#'
#' @noRd 
#' 
mod_strategy <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    plotObj <- 
      shinipsum::random_ggplot(type = "ribbon")
    
    dtObj <- 
      shinipsum::random_DT(nrow = 10, ncol = 5)
    
    # Q: is renderUI trying to build the whole page?
    output$page_ui <- renderUI({
      semanticPage(
        split_layout(cell_widths = c("50%", "50%"),
          plotOutput(plotObj),
          DTOutput(dtObj)
        )
      )
      
    })
    #mod_ambition_ui("ambition_ui_1")
    #mod_ambition_ui("priorities_ui_1")
    #mod_ambition_ui("timeframe_ui_1")
  })
}
    
## To be copied in the UI
# mod_strategy_ui("strategy_ui_1")
    
## To be copied in the server
# mod_strategy_server("strategy_ui_1")
