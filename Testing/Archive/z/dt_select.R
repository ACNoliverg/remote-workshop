library(shiny)
library(DT)
library(data.table)
library(purrr)

data <- data.table(Group = c("a", "a", "b", "b"), Item = c("c", "d", "f", "g"))

priorities_data <- 
  vroom::vroom("data/where-to-focus-v2.csv")


ui <- fluidPage(
  tags$head(tags$script(
    HTML(
      "Shiny.addCustomMessageHandler('unbindDT', function(id) {
        var $table = $('#'+id).find('table');
        if($table.length > 0){
          Shiny.unbindAll($table.DataTable().table().node());
        }
      })")
  )),
  selectInput("selectGroup", "Select Group", c("a", "b")),
  DT::dataTableOutput('ItemSelection'),
  htmlOutput("text")
)

server <- function(input, output, session) {
  output$ItemSelection <- DT::renderDT(
    {
      data_selected <- priorities_data

      data_selected$Item_Selection <-
        map_chr(1:nrow(data_selected), ~
                      as.character(selectInput(
                        paste0("Sel_Group_",as.character(.x) ),
                        label = "Choose a priority",
                        choices = c("Not a priority", "Low priority",
                                    "Medium priority", "High priority"),
                        width = "100px"))
              )
      
      datatable(
        data_selected, escape = FALSE, selection = 'none',
        options = list(
          dom = 't', 
          paging = FALSE, 
          ordering = FALSE,
          preDrawCallback = JS('function() { Shiny.unbindAll(this.api().table().node()); }'),
          drawCallback = JS('function() { Shiny.bindAll(this.api().table().node()); }')
        ),
        rownames = FALSE
      )
      
    }, server = FALSE)
  
  observeEvent(input$selectGroup, {
    session$sendCustomMessage("unbindDT", "ItemSelection")
  })
  
  
  output$text <- renderUI({
    purrr::map(.x = 1:nrow(priorities_data),
               .f = ~paste0("Priority ",as.character(.x)," is:", 
                            input[[paste0("Sel_Group_", as.character(.x))]])
    ) |>
      paste(sep = '<br>') |>
      HTML()
  })
}

  


shinyApp(ui, server)