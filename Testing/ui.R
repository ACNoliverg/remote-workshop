ui <- fluidPage(
  tabsetPanel(
    # 0 Landing page ----
    tabPanel(title = "Information",
             br(),
             sidebarLayout(
               sidebarPanel(
                 textInput("username", "Enter your name"),
                 textOutput("current_username")
               ),
               mainPanel(
                 textOutput("workshop_info")
               )
             )
          ),
    # 1 Performance panel ----
    tabPanel(title = "Current Performance",
             ## 1.1 Title ----
             titlePanel("Where do you think you are currently performing?"),
             textOutput("performance_info"),
             ## 1.2 Current performance selection table ----
             DTOutput("performance_table")),
    # 2 Ambition panel ----
    tabPanel("Ambition",
             ## 2.1 Title ----
             titlePanel("Where do you want to be?"),
             textOutput("ambition_info"),
             ## 2.2 Ambition level selection table ----
             DTOutput("ambition_table")),
    # 3 Priorities panel ----
    tabPanel("Priorities",
             ## 3.1 Title
             titlePanel("Choose your priorities"),
             textOutput("priorities_info"),
             ## 3.2 Subcategory priority selection table ----
             DTOutput("priorities_table"),
             ## 3.3 (for debug) HTML ----
             htmlOutput("priority_text")
    ),
    
    # 4 Timeframe panel ----
    tabPanel("Timeframe",
             ## 4.1 Title ----
             titlePanel("Whats the timeframe?"),
             textOutput("timeframe_info"),
             ## 4.3 DT ----
             DTOutput("timeframe_table"),
             ## 4.4 (for debug) HTML selection text ----
             htmlOutput("timeframe_text")),
    # 5 Strategy input summary panel ----
    tabPanel("Strategy Outputs",
             ## 5.1 Title ----
             titlePanel("Here's the results"),
             textOutput("inputs_tab_info"),
             ## 5.2 Ambition and performance text ----
             textOutput("performance_out_text"),
             textOutput("ambition_out_text"),
             ## 5.3 DT ----
             DTOutput("priority_timeframe_out")),
    # 6 Opportunity selection panel ----
    tabPanel("Top initiatives",
             ## 6.1 Title ----
             titlePanel("Refine the opportunity"),
             textOutput("initiatives_info"),
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
  )
)