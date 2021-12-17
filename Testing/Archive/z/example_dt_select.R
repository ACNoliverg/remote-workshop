library(shiny)
library(DT)
library(data.table)


data <- data.table(Group = c("a", "a", "b", "b"), Item = c("c", "d", "f", "g"))

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
  textOutput("selectedItem")
)

server <- function(input, output, session) {
  output$ItemSelection <- DT::renderDT(
    {
      data_selected <- data[Group == input$selectGroup]
      data_unique <- unique(data[Group == input$selectGroup, .(Group)])
      
      data_unique$Item_Selection[1] <-
        as.character(selectInput(
          "Sel_Group_1",
          label = NULL,
          choices = unique(data_selected[Group %in% data_unique[1], Item]),
          width = "100px"
        ))
      
      datatable(
        data_unique, escape = FALSE, selection = 'none',
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
  
  
  output$selectedItem <- renderText(paste0("Item selected is: ", input$Sel_Group_1))
}

shinyApp(ui, server)