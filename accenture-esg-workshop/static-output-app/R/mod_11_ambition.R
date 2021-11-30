library(shiny)
library(ggplot2)
library(thematic)

#--- Load all sub-modules with purrr
library(purrr)
paste0(
  "mod_11",
  c(
    "1_current_state",
    "2_future_state",
    "3_compare"
  ),
  ".R"
) %>% purrr::walk(source)

#   1. UI
# ------------

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
# Put together for testing purposes
ambition_App <- function() {
  ui <- fluidPage(
    ambition_UI("test")
  )
  server <- function(input, output, session) {
    ambition_Server("test")
  }
  shinyApp(ui, server)
}