library(shiny)
library(thematic)
library(ggplot2)
library(dplyr)
library(shinythemes)
library(bslib)
library(shiny.semantic)
library(semantic.dashboard)
#install.packages("languageserver")
#--- Config
ggplot2::theme_set(ggplot2::theme_minimal())

focus_options <-
  vroom::vroom("data/where-to-focus.csv") %>%
  rename(ESG = ...1, Subcategory = `ESG sub-categories`)

# Produce a random sample of data
dummy_priorities <- 
  focus_options %>% 
  mutate(lowCount = sample.int(10, nrow(focus_options), replace = T),
         medCount = sample.int(10, nrow(focus_options), replace = T),
         highCount = sample.int(10, nrow(focus_options), replace = T)
         )
# NOTE: the data loading and stuff is probably best put into a
# "utils" file of some kind
#   => Check the golem project I suppose

# I really want this file file to be AS CLEAN AS POSSIBLE,
# it will make such a huge difference for readibility
# overall.

# load in data sets
ambition_dummy_raw <-
  readRDS(file = "data/dummy_ambition_raw.RData")
ambition_dummy_comparative <-
  readRDS(file = "data/dummy_ambition_comparative.RData")

source("R/mod_11_ambition.R")
ui <- dashboardPage(
  dashboardHeader(
    # to fill
    color = "purple",
    title = "{semantic.dashboard}",
    inverted = TRUE,
    dropdownMenu(
      type = "notifications",
      taskItem(
        "Project progress...",
        50.777,
        color = "red"
      )
    )
  ),
  dashboardSidebar(
    # to fill
    size = "thin", color = "teal",
    sidebarMenu(
      menuItem(tabName = "strategy", "Strategy"),
      menuItem(tabName = "initiatives", "Initiatives"),
      menuItem(tabName = "outcomes", "Outcomes"),
      menuItem(tabName = "review", "Review")
    )
  ),
  dashboardBody(
    # to fill
    tabItems(
      #selected = 1,
      tabItem(
        tabName = "Welcome",
        h1("welcome")
      ),
      tabItem(
        tabName = "strategy",
        box(
          h1("Ambition"), title = "A b c", 
          width = 14,
          height = 4,
          color = "orange",
          
          tabset(
            tabs = list(
              current = list(
                menu = "Current Performance",
                content = current_state_UI("dashboard_current")
              ),
              future = list(
                menu = "Future Achievement",
                content = future_state_UI("dashboard_future")
              ),
              compare = list(
                menu = "The Road Ahead",
                content = compare_UI("dashboard_compare"))
            ),
            active = "first_tab",
            id = "ambition_component"
          )
        ),
      ),
      tabItem(
        tabName = "initiatives",
        h1("Initiatives")
      ),
      tabItem(
        tabName = "outcomes",
        h1("outcomes")
      ),
      tabItem(
        tabName = "review",
        h1("review")
      )
    )
  )
)


server <- shinyServer(
  function(input, output, session) {
    current_state_Server("dashboard_current", ambition_dummy_raw)
    future_state_Server("dashboard_future", ambition_dummy_raw)
    compare_Server("dashboard_compare", ambition_dummy_comparative)
  }
)

shinyApp(ui, server,
         options = list(
           test.mode = TRUE
         ))