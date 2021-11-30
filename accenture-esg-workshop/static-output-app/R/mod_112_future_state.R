future_state_UI <- function(id) { # nolint
  ns <- NS(id)
  tagList(
    tabPanel("Future State",
             plotOutput(ns("future_state_plot")
                        )
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
      future_state_UI(id)
      )
  server <- function(input, output, session) {
    future_state_Server(id, data_raw)
  }
  shiny::shinyApp(ui, server)
}