library(shiny)
library(shiny.semantic)
library(semantic.dashboard)
library(plotly)
library(DT)
library(purrr)
library(dplyr)
setwd("C:/Users/oliver.g.alexander/Projects/remote-workshop/Testing/strategy")
source("mod_strategy.R")
source("mod_ambition.R")
source("mod_priorities.R")
source("mod_timeframe.R")
#source("C:\Users\oliver.g.alexander\Projects\remote-workshop\Testing\strategy\mod_ambition.R")
#install.packages
#install.packages("formattable")
#library(typed)
library(fullPage)
app_ui <- function() { 
  
  options <- list()
  
  tagList(
    pagePiling(
      sections.color = c('#2f2f2f', '#2f2f2f', '#f9f7f1', '#2f2f2f'),
      opts = options,
      menu = c(
        "Welcome" = "welcome",
        "Strategy" = "strategy",
        "Duplicated Priorities" = "dup_priorities",
        "Initiatives" = "initiatives",
        "Review" = "review"
      ),
      pageSectionImage(
        center = TRUE,
        img = "img_1",
        menu = "Welcome",
        h1("A New Strategy", class = "header shadow-dark"),
        h3("A potential link",
          class = "light footer",
          "by", tags$a("news-r", href = "https://news-r.org", class = "link"), "with", emo::ji("coffee")
        )
      ),
      pageSection(
        center = TRUE,
        menu = "Strategy",
        mod_strategy_ui("strategy_ui")
      ),
      pageSection(
        center = TRUE,
        menu = "Duplicated Priorities",
        mod_ambition_ui("ambition_ui")
      ))
      #mod_ambition_ui("test")
  )
}
server <- function(input, output, session) {
  ns <- session$ns
  mod_ambition("ambition_ui")
  mod_strategy("strategy_ui")
  
  output$img_1 <- shiny::renderImage({
    shinipsum::random_ggplotly()
  })
  
}
  
runApp(shinyApp(app_ui(), server),display.mode = "showcase")


