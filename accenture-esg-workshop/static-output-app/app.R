library(shiny)
library(thematic)
library(ggplot2)
library(dplyr)
library(shinythemes)
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

# load in datasets
ambition_dummy_raw <-
  readRDS(file = "data/dummy_ambition_raw.RData")
ambition_dummy_comparative <-
  readRDS(file = "data/dummy_ambition_comparative.RData")

source('R/mod_11_ambition.R')
ui <- fluidPage(
  current_state_UI("test"), # from mod_11_ambition.R
  theme = shinythemes::shinytheme("flatly") # dunno if this is doing anything right now # nolint
)
thematic_shiny()
server <- function(input, output, session) {
  current_state_Server("test", ambition_dummy_raw)
}

shinyApp(ui, server)