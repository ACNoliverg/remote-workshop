server <- function(input, output, session) {
  
  # 0 Landing page ----
  username <- reactive({
    input$username
  })
  output$current_username <- renderText({
    paste0("Current username is: ",
           username())
  })
  output$workshop_info <- renderText({
    welcome_text
  })
  # 1 Strategy inputs ----
  ## 1.1 Performance ----
  ### 1.1.1 Selection table ----
  output$performance_table <- 
    renderDT({
      datatable(
        data = ambition_descriptions,
        selection = "single",
        rownames = FALSE,
        options = list(dom = "t")
      )})
  output$performance_info <- renderText({
    "Click to select the appropriate row"
  })
  
  ## 1.2 Ambition  ----
  ### 1.2.1 Selection table ----
  output$ambition_table <-
    renderDT({datatable(
      ambition_descriptions,
      selection = c('single'),
      rownames = FALSE,
      options = list(dom = 't'))
    })
  output$ambition_info <- renderText({
    "Click to select the appropriate row"
  })
  
  ## 1.3 Priorities ----
  output$priorities_info <- renderText({
    "Select your priority level for each subcategory (one for each row of the table)"
  })
  ### 1.3.1 Selection table ----
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
                        "High priority",
                        "Low priority", "Not a priority"
                      ),
                      width = "80px"))
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
  ### 1.3.2 (For debug) Priority text ----
  output$priority_text <- renderUI({
    purrr::map(.x = 1:nrow(priorities_data),
               .f = ~paste0("Priority ",as.character(.x)," is:", 
                            input[[paste0("Priority_", as.character(.x))]])
    ) |>
      paste(sep = '<br>') |>
      HTML()
  })
  
  ## 1.4 Timeframe ----
  ### 1.4.1 Selection table ----
  output$timeframe_info <- renderText({
    "Select your desired timeframe for each subcategory (one for each row of the table)"
    
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
  ### 1.4.2 (For debug) timeframe text ----
  output$timeframe_text <- renderUI({
    purrr::map(.x = 1:nrow(priorities_data),
               .f = ~paste0("Timeframe ",as.character(.x)," is:", 
                            input[[paste0("Timeframe_", as.character(.x))]])
    ) |>
      paste(sep = '<br>') |>
      HTML()
  })
  
  
  # 2 Strategy outputs ----
  ## 2.1 Users inputs ----
  output$inputs_tab_info <- renderText({
    "Confirm that the below inputs are correct"
  })
  ### 2.1.1 Performance ----
  ##### create reactive ----
  user_performance <- reactive({
    get_ambition(input$performance_table_rows_selected)
  })
  ##### text output ----
  output$performance_out_text <- 
    renderText({paste0("Performance: ",user_performance())})
  
  ### 2.1.2 Ambition ----
  #### Reactive ambition ----
  user_ambition <- reactive({
    get_ambition(input$ambition_table_rows_selected)
  })
  #### text output ----
  output$ambition_out_text <-
    renderText({paste0("Ambition: ", user_ambition())})
  
  ### 2.1.3 Priorities and timeframes ----
  ##### Reactive priorites & timeframes table ----
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
  ##### Render table UI component ----
  output$priority_timeframe_out <- renderDT({
    
    datatable(
      data = priority_and_timeframe_table(),
      selection = "none",
      rownames = FALSE,
      options = list(dom = "t")
    )
    
  })
  
  ### 2.1.4 Produce output chart ----
  
  ### 2.1.5 Submit to database ----
  
  ## 2.2 Group inputs ----
  
  
  # 3 Refinement ----
  output$initiatives_info <- renderText({
    "Change the include option to 'no' for any opportunities you wish to exclude"
  })
  ## 3.1 {Reactive} User relevant subcategories ----
  relevant_subcategories <- reactive({
    priority_and_timeframe_table() |>
      filter(Priority != "Not a priority") %>%
      pluck("Subcategory")
  })
  
  ## 3.2 {Reactive} Opportunities list ----
  filtered_ops <- reactive({
    ops_data <- opportunities_db
    
    ops_data |>
      filter(Subcategory %in% relevant_subcategories())
  })
  
  ## 3.3 Render opportunities selection table ----
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
  
  ## 3.4 {Reactive} Refined user inputs ----
  final_inputs <- reactive({
    dat <- filtered_ops() 
    # should really should just join with the 
    # timeframe_priorites_table
    dat |>
      left_join(priority_and_timeframe_table(),
                by = c("ESG", "Subcategory"))
  })
  
  
  # 4 Outcomes ----
  ## 4.1 {eventReactive} generate outcomes data ----
  output$outcomes_info <- renderText({
    "Click the 'reload' button to get the estimated impact of your selection"
  })
  
  outcomes_data <- eventReactive(input$load_outcomes,{
    dat <- 
      initiatives_db
    #-- filter for ambition
    dat |>
      filter(Ambition == user_ambition()) -> dat
    #-- filter-
    dat |>
      select(ESG, Subcategory, Timeframe, Opportunity,
                  Year, cost, value, net) -> to_join
    
    to_join |>
      inner_join(final_inputs(),
                 by = c("ESG",
                        "Subcategory",
                        "Timeframe",
                        "Opportunity")) -> out 
    
    return(out)
    
  })
  
  ## 4.2 Render outcomes DT ----
  output$dt_out <- renderDT({
    datatable(outcomes_data())
  })
  
  ## 4.3 Render outcomes plot ----
  output$plot_out <- renderEcharts4r({
    outcomes_data() |>
      group_by(ESG, Year) |>
      summarise(net = sum(net)) |>
      e_charts(Year) |>
      e_line(net) |>
      e_show_loading() |>
      e_title("Net outcome")
  })
  
  ## 4.4 environment outcomes plot and dt  ----
  output$plot_environment <- renderEcharts4r({
    outcomes_data() |>
      filter(ESG == "Environmental") |>
      group_by(Year) |>
      summarise(cost = sum(cost),
                value = sum(value),
                net = sum(net)) |>
      e_charts(Year) |>
      e_line(cost) |>
      e_line(value) |>
      e_line(net) |>
      e_show_loading() |>
      e_title("Environmental breakdown")
  })
  output$dt_environment <- renderDT({
    outcomes_data() |>
      filter(ESG == "Environmental") |>
      datatable()
  })
  
  ## 4.5 social outcomes plot and dt ----
  output$plot_social <- renderEcharts4r({
    outcomes_data() |>
      filter(ESG == "Social") |>
      group_by(Year) |>
      summarise(cost = sum(cost),
                value = sum(value),
                net = sum(net)) |>
      e_charts(Year) |>
      e_line(cost) |>
      e_line(value) |>
      e_line(net) |>
      e_show_loading() |>
      e_title("Social breakdown")
  })
  output$dt_social <- renderDT({
    outcomes_data() |>
      filter(ESG == "Social") |>
      datatable()
  })
  
  ## 4.6 governance outcomes plot and dt ----
  output$plot_governance <- renderEcharts4r({
    outcomes_data() |>
      filter(ESG == "Governance") |>
      group_by(Year) |>
      summarise(cost = sum(cost),
                value = sum(value),
                net = sum(net)) |>
      e_charts(Year) |>
      e_line(cost) |>
      e_line(value) |>
      e_line(net) |>
      e_show_loading() |>
      e_title("Governance breakdown")
  })
  output$dt_governance <- renderDT({
    outcomes_data() |>
      filter(ESG == "Governance") |>
      datatable()
  })
  
}