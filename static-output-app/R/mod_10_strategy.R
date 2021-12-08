require(shiny)

#   Ambition (made up of current state & future desired state)
#-------------------------------

strategyPanel_UI <- function(id) {
  
  ns <- NS(id)
  
  tagList(
    mainPanel(
      tabsetPanel(
        tabPanel("")      )
    )
  )
}
strategyPanel_Server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data 
  }
    )
}

strategyPanel_App <- function() {
  ui <- fluidPage(
    strategyPanel_UI("panel1")
  )
  server <- function(input, output, session) {
    stra
  }
}






#------------------------------- Hist
histogramUI <- function(id) {
  tagList(
    selectInput(NS(id, "var"), "Variable", choices = names(mtcars)),
    numericInput(NS(id, "bins"), "bins", value = 10, min = 1),
    plotOutput(NS(id, "hist"))
  )
}
histogramServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    data <- reactive(mtcars[[input$var]])
    output$hist <- renderPlot({
      hist(data(), breaks = input$bins, main = input$var)
    }, res = 96)
  })
}
histogramApp <- function() {
  ui <- fluidPage(
    histogramUI("hist1")
  )
  server <- function(input, output, session) {
    histogramServer("hist1")
  }
  shinyApp(ui, server)  
}