# create_welcome_body <- function(){
#   tagList(
#   sidebarLayout(
#     sidebarPanel(
#       textInput("username", "Enter your name"),
#       textOutput("current_username")
#     ),
#     mainPanel(
#       textOutput("workshop_info")
#     )
#   )
# )
# }
# create_performance_body <- function(){
#   tagList(
#   ## 1.1 Title ----
#   titlePanel("Choose the level of ambition that best reflects your current performance on sustainability"),
#   textOutput("performance_info"),
#   ## 1.2 Current performance selection table ----
#   DTOutput("performance_table")
#   )
# }
# create_ambition_body <- function() {
#   tagList(
#     ## 2.1 Title ----
#     titlePanel("Choose the level of ambition that you think you should strive for in your sustainability strategy"),
#     textOutput("ambition_info"),
#     ## 2.2 Ambition level selection table ----
#     DTOutput("ambition_table")
#   )
# }
# create_priorities_body <- function(){
#   tagList(
#     ## 3.1 Title
#     titlePanel("Select between high, low and not a priority for each ESG-subcategory from the drop down lists"),
#     textOutput("priorities_info"),
#     ## 3.2 Subcategory priority selection table ----
#     DTOutput("priorities_table")#,
#     ## 3.3 (for debug) HTML ----
#     #htmlOutput("priority_text")
#   )
# }
# create_timeframe_body <- function(){
#   tagList(
#     ## 4.1 Title ----
#     titlePanel("For each sub-category, select the timeframe you wish to achieve your ambition in from the drop-down box"),
#     textOutput("timeframe_info"),
#     ## 4.3 DT ----
#     DTOutput("timeframe_table")#,
#     ## 4.4 (for debug) HTML selection text ----
#     #htmlOutput("timeframe_text")
#   )
# }
# create_strategy_outputs_body <- function() {
#   tagList(
#     ## 5.1 Title ----
#     titlePanel("Confirm your selection"),
#     textOutput("inputs_tab_info"),
#     ## 5.2 Ambition and performance text ----
#     textOutput("performance_out_text"),
#     textOutput("ambition_out_text"),
#     ## 5.3 DT ----
#     DTOutput("priority_timeframe_out")
#   )
# }
# create_top_initiatives_body <- function() {
#   tagList(
#     ## 6.1 Title ----
#     titlePanel("Please select the five most important initiatives in each of the environmental, social and governance spaces (so 15 initiatives in total). Note the subcategories you can see here are those that you selected as either high or low priority"),
#     textOutput("initiatives_info"),
#     ## 6.2 DT ----
#     DTOutput("opportunities_table")
#   )
# }
# create_outcomes_body <- function() {
#   tagList(
#     ## 7.1 Title ----
#     titlePanel("Outcomes"),
#     textOutput("outcomes_info"),
#     ## 7.2 Load button ----
#     actionButton("load_outcomes", "Load results"),
#     ## 7.3 Echarts plot ----
#     echarts4rOutput("plot_out"),
#     ## 7.4 DT ----
#     DTOutput("dt_out")
#   )
# }
# ui <- fluidPage(
#   tabsetPanel(
#     # 0 Landing page ----
#     tabPanel(title = "Information",
#              br(),
#              create_welcome_body()
#           ),
#     # 1 Performance panel ----
#     tabPanel(title = "Current ESG Performance",
#              create_performance_body()
#              ),
#     # 2 Ambition panel ----
#     tabPanel("Ambition",
#     create_ambition_body(),
#             ),
#     # 3 Priorities panel ----
#     tabPanel("Priorities",
#              create_priorities_body(),
#     ),
#     # 4 Timeframe panel ----
#     tabPanel("Timeframe",
#              create_timeframe_body(),
#              ),
#     # 5 Strategy input summary panel ----
#     tabPanel("Strategy Outputs",
#              create_strategy_outputs_body(),
#              ),
#     # 6 Opportunity selection panel ----
#     tabPanel("Top initiatives",
#              create_top_initiatives_body(),
#              ),
#     # 7 Outcomes panel ----
#     tabPanel("Outcomes",
#       create_outcomes_body(),
#     ),
#   )
# )
ui <- create_newUI()