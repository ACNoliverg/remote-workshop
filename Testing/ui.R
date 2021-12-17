

ui <- fluidPage(
  tabsetPanel(
    #----- performance
    tabPanel(title = "Current Performance",
             titlePanel("Where do you think you are currently performing?"),
             actionButton("performance_submit", "Submit"),
             DTOutput("performance_table")),
    
    #------ Ambition
    tabPanel("Ambition",
             titlePanel("Where do you want to be?"),
             #-- submit
             actionButton("submit_ambition", "Submit"),
             #-- selection  
             DTOutput("ambition_table")),
    #----- Priorities
    tabPanel("Priorities",
             titlePanel("Choose your priorities"),
             #-- O
             actionButton("submit_priorities", "Submit"),
             DTOutput("priorities_table"),
             htmlOutput("priority_text")
    ),
    
    #----- Timeframe
    tabPanel("Timeframe",
             titlePanel("Whats the timeframe?"),
             #-- submit
             actionButton("submit_timeframe", "Submit"),
             DTOutput("timeframe_table"),
             htmlOutput("timeframe_text")),
    
    tabPanel("Strategy Outputs",
             titlePanel("Here's the results"),
             textOutput("performance_out_text"),
             textOutput("ambition_out_text"),
             DTOutput("priority_timeframe_out")),
    tabPanel("Top initiatives",
             titlePanel("Refine the opportunity"),
             DTOutput("opportunities_table")),
    tabPanel(
      titlePanel("Outcomes"),
      actionButton("load_outcomes", "Load results"),
      echarts4rOutput("plot_out"),
      DTOutput("dt_out")
      
      
    )
  ),
)