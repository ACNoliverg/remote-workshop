#      So I guess this module generate the experience of comparing current
#      feelings to the starting point


#     QUESTION: What kind of communication does this module need to have with
#       other modules that are part of the app
#             A) Database connection / shared data
#             B) A session id, participant identifier, class or object of
#                some kind.
#             C) Kinda needs to take in what are we actually looking at
#--------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------
library(AmesHousing)

#' Variable selection for plot user interface
#' 
#' @param id, character used to specify namespace, see \code{shiny::\link[shiny]{NS}}
#' 
#' @return a \code{shiny::\link[shiny]{tagList}} containing UI elements
varselect_mod_ui <- function(id) {
  ns <- NS(id)
  
  # Define choice for X and Y variable selection
  var_choices <- list(
    `Sale price` = "Sale_Price",
    `Total basement square feet` = "Total_Bsmt_SF",
    `First floor square feet` = "First_Flr_SF",
    ...
  )
  
  # assemble UI elements
  tagList(
    selectInput(
      ns("xvar"),
      "Select X variable",
      choices = var_choices,
      selected = "Lot_Area"
    ),
    selectInput(
      ns("yvar"),
      "Select Y variable",
      choices = var_choices,
      selected = "Sale_Price"
    )
  )
}


#' Variable selection module server-side processing
#' 
#' @param input, output, session, standard \code{shiny} boilerplate
#' 
#' @return list with following components
#' \describe{
#'   \item{xvar}{reactive character string indicating x variable selection}}
#'   \item{yvar}{reactive character string indicating y variable selection}
#'}
varselect_mod_server <- function(input, 
                                 output, 
                                 session) {
  
  return(
    list(
      xvar = reactive({ input$xvar }),
      yvar = reactive({ input$yvar })
    )
  )
}


#' Scatterplot module server-side processings
#' 
#' This module produces a scatterplot with the sales price against
#' as variable selected by the user.
#' 
#' @param input,output,session standard \code{shiny} boilerplate
#' @param dataset data frame (non-reactive) with variables necessary for scatterplot
#' @param plot1_vars list containing reactive x-variable name (called `xvar`)
#' and y-variable name (called `yvar`) for plot 1
#' @param plot2_vars list containing reactive x-variable name (called `xvar`)
#' and y-variable name (called `yvar`) for plot 2
scatterplot_server_mod <- function(input,
                                   output,
                                   sesion,
                                   dataset,
                                   plot1vars,
                                   plot2vars) {
  
  plot1_obj <- reactive({
    p <- scatter_sales(dataset, 
                       xvar = plot1vars$xvar(),  #-- Note the ()
                       yvar = plot1vars$yvar())
    return(p)
  })
  
  plot2_obj <- reactive({
    p <- scatter_sales(dataset, 
                       xvar = plot2vars$xvar(), 
                       yvar = plot2vars$yvar())
    return(p)
  })
  
  output$plot1 <- renderPlot({
    plot1_obj()
  })
  
  output$plot2 <- renderPlot({
    plot2_obj()
  })
}














