library(shiny)
library(ggplot2)
library(thematic)
require(shiny.fluent)

#--- Load all sub-modules with purrr
library(purrr)
component_module_filenames <-
  paste0(
    "R/mod_11", # ambition base name
    c(
      "1_current_state",
      "2_future_state",
      "3_compare"
     ),
    ".R"
)
component_module_filenames %>%
  purrr::walk(source) # walk is map but with side effects

#   1. UI
# ------------

ambition_UI <- function(id) { # nolint
  # Create the namespace for the module
  ns <- shiny::NS(id)
  # The ambition module is made up of the current_state,
  # future_state and compare submodules.
  tagList(
    segment("Ambition",
            tabset(
              tabs = list(
                current = list(
                  menu = "Current performance",
                  content = current_state_UI("current"),
                  id = ns("current_performance_tab")
                ),
                future = list(
                  menu = "Future achievement",
                  content = future_state_UI("test_future"),
                  id = ns("future_achievement_tab")
                ),
                compare = list(
                  menu = "The road ahead",
                  content = compare_UI("test_compare"),
                  id = ns("road_ahead_tab")
                )
              ),
              id = ns("ambition_tabset")
            )
    )
  )
}
# Similarly the module server will be a composition of analogous
# sub-modules servers
ambition_Server <- function(id, data_raw, data_compare) { # nolint
  moduleServer(id, function(input, output, session) {
    current_state_Server("current_state", data_raw = data_raw) # nolint
    future_state_Server("future_state", data_raw = data_raw) # nolint
    compare_Server("compare", data_compare = data_compare) # nolint
  })
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