source("global.R")
# Module: Current performance
library(shiny)

##---------------------------- 1. UI 
#----------------------------------------

currentPerformance_UI <- function(id) {
  #-- 1.1 Define the input and output tabs
  
  # 1.1.1 input
  choose_performanceTab <- 
    tabPanel(title = "Current Performance",
             titlePanel("Where do you think you are currently performing?"),
             loadingButton(NS(id,"performance_submit"), "Submit"),
             DTOutput(NS(id, 'performance_choices'))
             )
  # 1.1.2 output
  compare_performanceTab <-
    tabPanel("Our performance", 
             loadingButton(NS(id,"performance_reload"), "reload"),
             plotOutput(NS(id, "performance_plot"))
             )
  
  #-- 1.2 Combine into the UI component of module
  
  tagList(
    tabPanel(title = "2. Comparing Strategies", 
             br(),
             tabsetPanel(choose_performanceTab, compare_performanceTab)
             )
    )
}

##---------------------------- 2. Server 
#----------------------------------------

currentPerformance_Server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Render the Table with the appropriate options
    output$performance_choices <-
      renderDT(
        ambition_descriptions,
        selection = c('single'),
        rownames = FALSE,
        option = list(dom = 't')
      )
    
    # Update the 
    eventReactive(input$performance_reload, {
      #      
      read_sheet(ss = performance_id) %>%
        as_tibble()
      }
    )
    }
  )
}

##---------------------------- 3. Create the test app
#----------------------------------------
currentPerformance_App <- function() {
  ui <- fluidPage(
    currentPerformance_UI("Test"),
    useShinyFeedback(FALSE),
    theme = shinytheme("sandstone"),
  )
  server <- function(input, output, session) {
    currentPerformance_Server("Test")
  }
  shinyApp(ui, server)
}
currentPerformance_App()