future_state_UI <- function(id) { # nolint
  ns <- NS(id)
  tagList(
    plotOutput(ns("future_state_plot")
                        )
    )
}
future_state_Server <- function(id, data_raw) { # nolint
  thematic_shiny() # nolint
  moduleServer(id, function(input, output, session) {
    output$future_state_plot <- renderPlot(
      ggplot(data_raw, aes(y = Ambition, x = nVotesFuture,
                                     fill = Ambition)
      ) +
        geom_bar(stat = "identity") +
        theme_minimal() +
        ggtitle("Desired future achievement")
    )
  }
  )
}
# This is only really called for testing purposes I believe
# (could be wrong there though...)
future_state_App <- function(id, data_raw) { # nolint

  ui <- fluidPage(
      future_state_UI("test")
      )
  server <- function(input, output, session) {
    future_state_Server("test", data_raw)
  }
  shiny::shinyApp(ui, server)
}
future_state_App(data_raw = ambition_dummy_raw)