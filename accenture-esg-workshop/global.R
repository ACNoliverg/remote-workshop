library(shiny)
library(tidyverse)
library(DT)
library(vroom)
library(shinydashboard)
library(htmltools)
library(data.table)
library(googlesheets4)
library(googledrive)
library(shinyFeedback)
library(shinythemes)

#token_path <- 
#  "utility-time-326221-47f48a58304a.json"

gs4_auth(
  email = "acn.oliver.g.alexander@gmail.com",
  cache = "google-cache/"
)
# global.2 Initialize google sheets database
todays_date <- lubridate::today()

#current_performance_sheet <-
#  gs4_create(name = paste0(todays_date, "_current_performance_chart"))

#ambitions_sheet <-
#  gs4_create(name = paste0(todays_date, "_ambitions_responses"))

#esg_priority_sheet <-
#  gs4_create(name = paste0(todays_date, "_esg-priority-responses"))

#timeframe_sheet <-
#  gs4_create(name = paste0(todays_date, "_timeframe-responses"))

gs4_auth_configure(api_key = "AIzaSyADVX806zM7HEiTO4BNuLVX-6K5w-HCa0g")

performance_id <-
  paste0("https://docs.google.com/spreadsheets/d/1zipjS_vDV5SGDUggRZNbByDtraioGbYTwCOXERSlRPY/edit?usp=sharing",
         "key=", gs4_api_key())

ambition_id <-
  paste0("https://docs.google.com/spreadsheets/d/1Nqx_TM_8XFscs_6y4wGwVt6g5GUB8E7x_0ZW79PJMSY/edit?usp=sharing",
         "key=", gs4_api_key())

priority_id <-
  paste0("https://docs.google.com/spreadsheets/d/1CeFzZetfcL2HtvtaBzXgrsQwJ-21t9_nDMq_f2WXT_E/edit?usp=sharing",
         "key=",gs4_api_key())

timeframe_id <-
  paste0("https://docs.google.com/spreadsheets/d/14lhZf8ZvAyTKqBRh99a6YFwqiQ-j_L_NxkZ7MaI9tDI/edit?usp=sharing",
    "key=",gs4_api_key())


initiatives_db <-
  vroom::vroom("data/initiatives_database.csv"
               )


ambition_descriptions <- 
  vroom::vroom("data/ambition_descriptions_v2.csv",
               col_select = c(Ambition, Description, Who, Example)
               ) 

get_ambition <-
  function(index) {
    ambition_descriptions$Ambition[index]
  }

convert_row_to_button <-
  function(i) {
    paste0('<select id="', 'priority_input_', i,  '" style="width: 100%;">
                       <option value="" selected></option>
                       <option value="High priority">High priority</option>
                       <option value="Low priority">Low priority</option>
                       <option value="Not a priority">Not a priority</option>
                       </select>')
  }

convert_index_to_ESG_category <-
  function(i) {
    
  }

focus_data <- 
  vroom::vroom("data/where-to-focus.csv") %>%
  rename(ESG = ...1, Subcategory = `ESG sub-categories`) %>%
  mutate(Priority = '<select id="single_select" style="width: 100%;">
                       <option value="" selected></option>
                       <option value="High priority">High priority</option>
                       <option value="Low priority">Low priority</option>
                       <option value="Not a priority">Not a priority</option>
                       </select>')

js <- c(
  "function(settings){",
  "  $('[id^=Slider]').ionRangeSlider({",
  "    type: 'double',",
  "    grid: true,",
  "    grid_num: 10,",
  "    min: 0,",
  "    max: 20",
  "  });",
  "  $('#mselect').selectize()",
  "}"
)
# 

# initiatives_db %>%
#   drop_na() %>% 
#   select(ESG, Subcategory, Ambition, Timeframe, Opportunity) %>%
#   distinct(ESG, Subcategory, Ambition, Timeframe, .keep_all = T) %>% 
#   group_by(ESG, Subcategory, Ambition,Timeframe) %>%
#   summarise(nOpp = n_distinct(Opportunity  )) %>% 
#   arrange(desc(nOpp))

# intiatives_db %>% 
#   drop_na() %>%
#   select(-contains("net")) %>%
#   pivot_longer(cols = contains("Year"),
#                names_to = c(NA, "Year", "type"),
#                names_sep = " ",
#                names_transform = list("Year" = as.integer),
#                values_to = "amount") %>%
#     pivot_wider(names_from = "type",
#                 values_from = "amount") -> t
# 
# t %>%
#   mutate(net = cost + value,)
#                            
# names(intiatives_db) <-
#   intiatives_db %>%
#   names() %>%
#   map(~str_extract(.x, pattern = "Year "))
# 
# 
# t %>%
#   mutate(net = cost + value) %>%
#   write.csv("data/initiatives_db_long.csv")


