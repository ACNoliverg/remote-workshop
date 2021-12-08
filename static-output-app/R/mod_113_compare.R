compare_UI <- function(id) { # nolint
  ns <- NS(id)
  tagList(
    tabPanel("The road ahead",
             plotOutput(ns("compare_plot")
                        )
             )
    )
}
compare_Server <- function(id, data_compare) { # nolint
  thematic_shiny() # nolint
  moduleServer(id, function(input, output, session) {
    output$compare_plot <- renderPlot(
      ggplot(data_compare, aes(y = Ambition, x = Votes,
                                     fill = presentOrFuture)
      ) +
        geom_bar(stat = "identity", 
                 position = "dodge") +
        theme_minimal() +
        ggtitle("Desired future achievement")
    )
  }
  )
}
# This is only really called for testing purposes I believe
# (could be wrong there though...)
compare_App <- function(id, data_compare) { # nolint

  ui <- fluidPage(
      compare_UI(id)
      )
  server <- function(input, output, session) {
    compare_Server(id, data_compare)
  }
  shiny::shinyApp(ui, server)
}