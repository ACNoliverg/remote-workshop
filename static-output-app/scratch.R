#--- Trying out a spider plot
require(shiny)
require(plotly)
require(tidyverse)
#-- Still need the data
ambition_dummy_comparative <-
  readRDS(file = "data/dummy_ambition_comparative.RData")
ambition_dummy_raw <-
  readRDS(file = "data/dummy_ambition_raw.RData")

spiderplot_UI <- function(id) {
  # create namespace for the module
  ns <- NS(id)
  shiny::tagList(
    plotlyOutput(ns("spider_plot"))
  )
}
#-- Evidently these are utils_* for the module
get_performance <- function(category, comparative_data, current_or_future) {
  comparative_data %>%
    #mutate_if(is.factor, as.character) %>%
    filter(Ambition == category,
           presentOrFuture == current_or_future
           ) %>%
    pluck("Votes") %>%
    c()
}
get_currentPerformance <-
  purrr::partial(get_performance, current_or_future = "Current")
get_futurePerformance <-
  purrr::partial(get_performance, current_or_future = "Future")
#--
spiderplot_Server <- function(id, data_input) {
  # The different categories of ambition
  categories <- data_input %>%
    distinct(Ambition)
  # module server
  moduleServer(
    id,
    function(input, output, session) {
      output$spider_plot <-
      renderPlotly({
      plot_ly(
        type = "scatterpolar",
        fill = "toself"
      ) %>%
      add_trace(
        # r is the distance from the centre (i.e the value in each of the categories) # nolint
        r = map_int(
          .x = categories,
          .f = get_currentPerformance,
          comparative_data = data_input
        ),
        theta = categories,
        name = "Our Curent Performance"
      ) %>%
      layout(
        polar = list(
          radialaxis = list(
            visible = TRUE,
            range = c(0,100)
          )
        )
      )
    })}
    )
}
spiderplot_App <- function() {
  ui <- fluidPage(
    spiderplot_UI("test")
  )
  server <- spiderplot_Server("test", ambition_dummy_raw)
  shiny::shinyApp(ui, server)
}
spiderplot_App()