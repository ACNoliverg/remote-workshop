library(shiny)
library(shinyFeedback)
library(shinythemes)
library(reactlog)
# Module: Welcome
# Action: Authenticates and

reactlog_enable()

# 1. Module UI
welcomeUI <- function(id) { # nolint
    tagList(
        tabPanel(title = "Welcome!",
           titlePanel("Thank you for joining our workshop."),
           textInput(NS(id, "username"), "Please enter your name"),
           loadingButton(NS(id, "submit_name"),
                         label = "Submit",
                         loadingLabel = "Submitting...")
           )
    )
}
welcomeServer <- function(id) { # nolint
    moduleServer(id, function(input, output, session) {
        # User attempts to submit their credentials
        observeEvent(input$submit_name, {
            Sys.sleep(3)
            resetLoadingButton("submit_name")
            showToast(
                "success",
                paste0("Thanks ",
                        input$username,
                       "! Head over to '1. Current performance'")
                )
            }
        )
    }
    )
}
welcomeApp <- function() {
    ui <- fluidPage(
        welcomeUI("Test"),
        useShinyFeedback(FALSE),
        theme = shinytheme("sandstone"),
    )
    server <- function(input, output, session) {
        welcomeServer("Test")
    }
    shinyApp(ui, server)
}
welcomeApp()
