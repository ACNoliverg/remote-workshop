#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


#####         Welcome
##### ------------------------------------------------------
welcomeTab <-
  tabPanel(title = "Welcome!",
           titlePanel("Thank you for joining our workshop."),
           textInput("username", "Please enter your name"),
           loadingButton(inputId = 'nameSubmit',
                         label = "Submit",
                         loadingLabel = 'Submitting...')
           )


toolinstructionTab <-
  tabPanel("Tool Instructions")
p

#####         Choose Your Strategy
##### ------------------------------------------------------           
chooseperformanceTab <-
  tabPanel(title = "Current Performance",
           titlePanel("Where do you think you are currently performing?"),
           loadingButton("performance_submit", "Submit"),
           DTOutput('performance_choices')
           )
chooseambitionTab <-
  tabPanel(title = "Ambition",
           titlePanel("Who do you want to be?"),
           loadingButton("ambition_submit", "Submit"),
           DTOutput('ambition_choices')
           )
choosepriortiesTab <-
  tabPanel(title = "ESG Priorities",
           titlePanel("Where do your priorities lie?"),
           loadingButton("priorities_submit", "Submit"),
           DTOutput("prorities_choices")
  )
choosetimeframesTab <-
  tabPanel(title = '3. Timeframe',
           loadingButton("timeframe_submit", "Submit"),
           titlePanel("What is your timeframe?")
  )



chooseTab <-
  tabPanel("title = 1. Choose your Strategy", br(),
           tabsetPanel(chooseperformanceTab, chooseambitionTab, choosepriortiesTab, choosetimeframesTab)
  )

#####         Compare Strategies
##### ------------------------------------------------------

compareperformanceTab <-
  tabPanel("Our performance", 
           loadingButton("performance_reload", "reload"),
           plotOutput("performance_plot"))
compareambitionTab <-
  tabPanel(title = "Our Ambitions",
            loadingButton("ambition_reload", "reload"),
            plotOutput("ambition_plot"))
compareprioritiesTab <-
  tabPanel(title = "ESG Priorities",
           loadingButton("priorities_reload", "reload")#,
           #plotOutput("priorities_plot")
           )
comparetimeframeTab <-
  tabPanel(title = "ESG Priorities",
           loadingButton("priorities_reload", "reload")#,
           #plotOutput("priorities_plot")
  )
comparetopTab <-
  tabPanel(title = "Top initiatives", 
           loadingButton("topInitiaves_reload", "reload")#,
           #plotOutput("performance_plot")
  )


compareTab <-
  tabPanel(title = "2. Comparing Strategies", br(),
           tabsetPanel(compareperformanceTab, compareambitionTab, compareprioritiesTab, comparetimeframeTab, comparetopTab))

#####         Evaluate
##### ------------------------------------------------------


evaluateTab <-
  tabPanel(title = "3. Evaluate")

shinyUI(fluidPage(
    
    useShinyFeedback(TRUE),
    theme = shinytheme("sandstone"),
    
    # Application title
    titlePanel("Accenture ESG Workshop"),

    tabsetPanel(welcomeTab, toolinstructionTab, chooseTab, compareTab, evaluateTab)
    )
    )
               
 

    

