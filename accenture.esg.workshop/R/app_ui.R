#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom semantic.dashboard dashboardHeader dropdownMenu taskItem
#' @importFrom semantic.dashboard dashboardSidebar sidebarMenu menuItem
#' @importFrom semantic.dashboard dashboardPage dashboardBody
#' @importFrom shiny.semantic semanticPage action_button
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    dashboardPage(
      dashboardHeader(color = "purple", title = "ESG", inverted = TRUE,
                      dropdownMenu(type = "notifications",
                                    taskItem("Projet progress...", 50.777, color = "red"))),
      dashboardSidebar(
        size = "thin", color = "teal",
        sidebarMenu(
          menuItem(tabName = "main", "Main"),
          menuItem(tabName = "extra", "Extra")
          ) 
      ),
      dashboardBody(
        semanticPage(
          shiny::actionButton("browser", "browser"),
          tags$script("$('#browser').hide();"),
          shiny::h5("test"),
          mod_main_ui("main_ui_1"))),
      )
    )
}
#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'accenture.esg.workshop'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

