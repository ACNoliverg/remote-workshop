server <- function(input, output, session) {
  
  userInputs <- reactiveValues(in_performance = NULL,
                               in_ambition = NULL,
                               in_priorities = NULL,
                               in_timefame = NULL,
                               in_top_5 = NULL,
                               combined_table = NULL)
  
  
  #-----
  observeEvent(input$submit_performance, {
    userInputs$in_performance <- priorities_data |>
      mutate(priority = map_chr())
  }) 
  observeEvent(input$submit_ambition, {
    userInputs$in_ambition <- input$ambition()
  })
  observeEvent(input$submit_priorites, {
    userInputs$inpriorities <- input$priorities()
    
    # mutate(Priorities = map(1:nrow, ~input[[paste0]]))
  })
  observeEvent(input$submit_timeframe, {
    userInputs$timeframe <- input$timeframe() 
    
    userInputs$combined_table <-
      tibble(Subcategory = esg_subcategories, 
             userInputs$timeframe())
  })
  observeEvent(input$submit_top_5, {
    userInputs$in_top_5 <- input$top_5()
  })
  
  #---------- Tables
  #--
  #----- Strategy inputs
  
  output$ambition_table <-
    renderDT({datatable(
      ambition_descriptions,
      selection = c('single'),
      rownames = FALSE,
      options = list(dom = 't'))
    })
  output$performance_table <- 
    renderDT({
      datatable(
        data = ambition_descriptions,
        selection = "single",
        rownames = FALSE,
        options = list(dom = "t")
      )})
  output$priorities_table <-
    DT::renderDT(
      {
        data_selected <- priorities_data
        
        data_selected$Priority <-
          map_chr(1:nrow(data_selected), ~
                    as.character(selectInput(
                      paste0("Priority_",as.character(.x) ),
                      label = NULL,
                      choices = c(
                        "High priority","Medium priority",
                        "Low priority", "Not a priority"
                      ),
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
  output$priority_text <- renderUI({
    purrr::map(.x = 1:nrow(priorities_data),
               .f = ~paste0("Priority ",as.character(.x)," is:", 
                            input[[paste0("Priority_", as.character(.x))]])
    ) |>
      paste(sep = '<br>') |>
      HTML()
  })
  
  output$timeframe_table <-
    DT::renderDT(
      {
        data_selected <- priorities_data
        
        data_selected$Timeframe <-
          map_chr(1:nrow(data_selected), ~
                    as.character(selectInput(
                      paste0("Timeframe_",as.character(.x) ),
                      label = NULL,
                      choices = c("1-3 years", "<5 years",
                                  "<10 years"),
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
  output$timeframe_text <- renderUI({
    purrr::map(.x = 1:nrow(priorities_data),
               .f = ~paste0("Timeframe ",as.character(.x)," is:", 
                            input[[paste0("Timeframe_", as.character(.x))]])
    ) |>
      paste(sep = '<br>') |>
      HTML()
  })
  
  
  #----- Strategy Outputs
  user_performance <- reactive({
    get_ambition(input$performance_table_rows_selected)
  })
  user_ambition <- reactive({
    get_ambition(input$ambition_table_rows_selected)
  })
  output$performance_out_text <- 
    renderText({paste0("Performance: ",user_performance())})
  output$ambition_out_text <-
    renderText({paste0("Ambition: ", user_ambition())})
  priority_and_timeframe_table <- reactive({
    data_out <- priorities_data |> select(-Description)
    
    data_out$Priority = map_chr(1:nrow(priorities_data),
                                ~input[[paste0("Priority_", as.character(.x))]])
    data_out$Timeframe = map_chr(1:nrow(priorities_data),
                                 ~input[[paste0("Timeframe_", as.character(.x))]])
    data_out |> 
      rename(ESG = `ESG Category`) -> data_out
    return(data_out)
  })
  relevant_subcategories <- reactive({
    priority_and_timeframe_table() |>
      filter(Priority != "Not a priority") %>%
      pluck("Subcategory")
  })
  output$priority_timeframe_out <- renderDT({
    # data_out <- priorities_data |> select(-Description)
    # 
    # data_out$Priority = map_chr(1:nrow(priorities_data),
    #                            ~input[[paste0("Priority_", as.character(.x))]])
    # data_out$Timeframe = map_chr(1:nrow(priorities_data),
    #                            ~input[[paste0("Timeframe_", as.character(.x))]])
    # 
    datatable(
      data = priority_and_timeframe_table(),
      selection = "none",
      rownames = FALSE,
      options = list(dom = "t")
    )
    
  })
  output$strategy_text_sum <- renderText("Hi")
  
  
  #----- Opportunity Selection
  filtered_ops <- reactive({
    ops_data <- opportunities_db
    
    ops_data |>
      filter(Subcategory %in% relevant_subcategories())
  })
  output$opportunities_table <- DT::renderDT(
    {
      data_selected <- filtered_ops()
      
      data_selected$`Include?` <-
        map_chr(1:nrow(filtered_ops()), ~
                  as.character(selectInput(
                    paste0("Opportunity_",as.character(.x) ),
                    label = NULL,
                    choices = c("Yes", "No"),
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
  final_inputs <- reactive({
    dat <- filtered_ops() 
    #--- should really should just join with the 
    #--- timeframe_priorites_table
    dat |>
      left_join(priority_and_timeframe_table(),
                by = c("ESG", "Subcategory"))
  })
  
  
  outcomes_data <- eventReactive(input$load_outcomes,{
    dat <- initiatives_db
    
    #-- filter for ambition
    dat |> filter(Ambition == user_ambition()) -> dat
    #-- filter-
    dat |> select(ESG, Subcategory, Timeframe, Opportunity,
                  Year, cost, value, net) -> to_join
    
    to_join |>
      inner_join(final_inputs(),
                 by = c("ESG",
                        "Subcategory",
                        "Timeframe",
                        "Opportunity")) -> out 
    
    return(out)
    
  })
  output$dt_out <- renderDT({
    datatable(outcomes_data())
  })
  
  output$plot_out <- renderEcharts4r({
    outcomes_data() |>
      group_by(ESG, Year) |>
      summarise(net = sum(net)) |>
      e_charts(Year) |>
      e_line(net) |>
      e_show_loading() |>
      e_title("Net outcome")
  })
}