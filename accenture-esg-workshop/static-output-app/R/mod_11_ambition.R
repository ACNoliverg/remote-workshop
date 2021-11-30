library(shiny)
library(ggplot2)
library(thematic)

#--- Module

ambition_UI <- function(id) {
  # Create the namespace for the module
  ns <- NS(id)
  # The ambition module is made up of the current_state,
  # future_state and compare submodules.
  tagList(
    tabsetPanel(
      tabPanel(
        current_state_UI("current")
      ),
      tabPanel(
        future_state_UI("future")
      ),
      tabPanel(
        comparison_UI("compare")
      )
      )
    )
}
# Similarly the module server will be a composition of analogous
# sub-modules servers
ambition_Server <- function(id) {
  
  current_state_Server("current_state")
  future_state_Server("future_state")
  compare_states("compare")
  
}
# 
# 
# 
# #- NS(id)
#   
#   currentStateTab <- tabPanel()
#   
#   tabs <- tabsetPanel(type="pills",
#                       tabPanel(ns("current_state_tab"),
#                                plotOutput())
#   
#   tagList(
#     sidebarLayout(
#       sidebarPanel(
#         # perh
#       ),
#       mainPanel(
#         
#       )
#     )
#   )
# }
# mod_11_ambition_Server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#     
#     output$current_state_plot <- renderPlot(
#       ggplot(ambition_dummy_raw, aes(y = Ambition, x = nVotesCurrent,
#                                      fill = Ambition)
#       ) +
#         geom_bar(stat="identity") +
#         theme_minimal() +
#         ggtitle("Current performance")
#     )
#   })
# }
# mod_11_ambition_App <- function(id) {
#   
#   ui <- fluidPage(
#     mod_11_ambition_UI(id)
#     )
#   
#   server <- mod_11_ambition_Server(id)
#   
#   
#   shinyApp(ui, server)
# }


  