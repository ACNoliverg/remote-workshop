create_newUI <- function(){
  dashboardPage(
    dashboardHeader(
      color = "purple",
      title = "ESG Workshop",
      inverted = TRUE
  ),
  dashboardSidebar(
    size = "thin", color = "teal",
    sidebarMenu(
      menuItem(tabName = "welcome",
               "Welcome and instructions"),
      menuItem(tabName = "strategy",
               "Sustainability Strategy"),
      menuItem(tabName = "your_strategy",
               "Output: Your sustainability strategy"),
      menuItem(tabName = "top_initiatives",
               "Your top 5 initiatives"),
      menuItem(tabName = "combined_outputs",
               "Output: Combined strategy")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "welcome",
        box(width = 16,
          create_welcome_body()
        )
      ),
      tabItem(
        tabName = "strategy",
        box(width = 16,
            tabset(
              tabs = list(
                current = list(
                  menu = "Current Performance",
                  content = create_performance_body()
                ),
                ambition = list(
                  menu = "Ambition",
                  content = create_ambition_body()
                ),
                priorities = list(
                  menu = "Priorities",
                  content = create_priorities_body()
                ),
                timeframe = list(
                  menu = "Timeframes",
                  content = create_timeframe_body()
                )
              )
            )
        )
      ),
      tabItem(
        tabName = "your_strategy",
        box(width = 16,
            create_strategy_outputs_body())
      ),
      tabItem(
        tabName = "top_initiatives",
        box(width = 16,
            tabset(
              tabs = list(
                initiatives = list(
                  menu = "Opportunity refinement",
                  content = create_top_initiatives_body()
                ),
                outcomes = list(
                  menu = "Outcomes",
                  content = create_outcomes_body()
                ),
                environment = list(
                  menu = "Environment",
                  content = create_environment_body()
                ),
                social = list(
                  menu = "Social",
                  content = create_social_body()
                ),
                governance = list(
                  menu = "Governance",
                  content = create_governance_body()
                )
              )
            )
          )
        ),
      tabItem(
        tabName = "combined_outputs",
        box(width = 16,
            h1("Next"))
      )
    )
  )
)}
