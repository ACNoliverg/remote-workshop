

ui <- fluidPage(
  tabsetPanel(
    # 1 Performance panel ----
    tabPanel(title = "Current Performance",
             ## 1.1 Title ----
             titlePanel("Where do you think you are currently performing?"),
             ## 1.2 Current performance selection table ----
             DTOutput("performance_table")),
    # 2 Ambition panel ----
    tabPanel("Ambition",
             ## 2.1 Title ----
             titlePanel("Where do you want to be?"),
             ## 2.2 Ambition level selection table ----
             DTOutput("ambition_table")),
    # 3 Priorities panel ----
    tabPanel("Priorities",
             titlePanel("Choose your priorities"),
             ## 3.1 Submit button ----
             actionButton("submit_priorities", "Submit"),
             ## 3.2 DT ----
             DTOutput("priorities_table"),
             ## 3.3 (for debug) HTML ----
             htmlOutput("priority_text")
    ),
    
    # 4 Timeframe panel ----
    tabPanel("Timeframe",
             ## 4.1 Title ----
             titlePanel("Whats the timeframe?"),
             ## 4.2 Submit button ----
             actionButton("submit_timeframe", "Submit"),
             ## 4.3 DT ----
             DTOutput("timeframe_table"),
             ## 4.4 (for debug) HTML selection text ----
             htmlOutput("timeframe_text")),
    # 5 Strategy input summary panel ----
    tabPanel("Strategy Outputs",
             ## 5.1 Title ----
             titlePanel("Here's the results"),
             ## 5.2 Ambition and performance text ----
             textOutput("performance_out_text"),
             textOutput("ambition_out_text"),
             ## 5.3 DT ----
             DTOutput("priority_timeframe_out")),
    # 6 Opportunity selection panel ----
    tabPanel("Top initiatives",
             ## 6.1 Title ----
             titlePanel("Refine the opportunity"),
             ## 6.2 DT ----
             DTOutput("opportunities_table")),
    # 7 Outcomes panel ----
    tabPanel(
      ## 7.1 Title ----
      titlePanel("Outcomes"),
      ## 7.2 Load button ----
      actionButton("load_outcomes", "Load results"),
      ## 7.3 Echarts plot ----
      echarts4rOutput("plot_out"),
      ## 7.4 DT ----
      DTOutput("dt_out")
    )
  ),
)