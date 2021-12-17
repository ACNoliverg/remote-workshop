current_state_UI <- function(id) { # nolint
  ns <- NS(id)
  tagList(
          plotOutput(ns("current_state_plot")
              )
    )
}
current_state_Server <- function(id, data_raw) { # nolint
  thematic_shiny() # nolint
  moduleServer(id, function(input, output, session) {
    output$current_state_plot <- renderPlot(
      ggplot(data_raw, aes(y = Ambition, x = nVotesCurrent,
                                     fill = Ambition)
      ) +
        geom_bar(stat = "identity", show.legend = FALSE) +
        theme_minimal() +
        ggtitle("Current performance")
    )
  }
  )
}
current_state_App <- function(data_raw) { # nolint

  ui <- fluidPage(
      current_state_UI("test")
      )
  server <- function(input, output, session) {
    current_state_Server("test", data_raw)
  }
  shiny::shinyApp(ui, server)
}
# For testing purposes
current_state_App(data_raw = ambition_dummy_raw)