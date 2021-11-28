library(shiny)
#install.packages("shiny", dependencies=TRUE)
#install.packages("mime", dependencies=TRUE)
library(reactlog)
library(plotly)
reactlog_enable()

ui <- fluidPage(
  selectInput("var", "Choose a variable", choices = names(diamonds)),
  plotlyOutput("plot")
)

#remove.packages("mime")

server <- function(input, output, session) {
  output$plot <- renderPlotly({
    plot_ly(x = diamonds[[input$var]])
  })
}

shinyApp(ui, server)
