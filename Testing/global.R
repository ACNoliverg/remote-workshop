library(shiny)
library(data.table)
library(DT)
library(vroom)
library(tidyverse)
library(echarts4r)
library(reactlog)
library(googlesheets4)
library(googledrive)

#------ Loading data -------
ambition_descriptions <- 
  vroom::vroom("data/ambition_descriptions_v2.csv",
               col_select = c(Ambition, Description, Who, Example))
get_ambition <-
  function(index) {
    ambition_descriptions$Ambition[index]
  }
priorities_data <- 
  vroom::vroom("data/where-to-focus-v3.csv")
# initiatives_db |>
#   distinct(ESG, Subcategory, Opportunity) -> ops
# ops |>
# saveRDS("data/opporunity_db.RData")

opportunities_db <- readRDS("data/opporunity_db.RData")

initiatives_db <-
  vroom::vroom("data/initiatives_db_long.csv")

# Landing ----
welcome_text <- "This spreadsheet allows client participants to create and workshop their own sustainability strategy. Participants shape their strategy by choosing their level of ambition, priority areas and timeframe for their strategy. This generates a list of initiatives along with an indicative cost for implementing these initiatives. Each participant in the workshop should have their own version of the file which links each participant's results to a summary spreadsheet where the group can see whether their level of ambition, priority, timeframe and costs are aligned or not."

# Google sheets setup ----
## Generating token ----
### Designate the cache location ---- 
# options(gargle_oauth_cache = ".secrets")
# 
# ### check the value ----
# gargle::gargle_oauth_cache()
# 
# ### (pre-deployment) interatively generate token ----
# googlesheets4::gs4_auth()
# 
# ### Check the token file was created ----
# list.files(".secrets/")
# 
# ### Deauth ----
# googlesheets4::gs4_deauth()
# 
# ## Testing authentication ----
# ### Directly
# googlesheets4::gs4_auth(
#   cache = ".secrets",
#   email = "acn.oliver.g.alexander@gmail.com"
# )
## deauth ----
#googlesheets4::gs4_deauth()
## Set values in options ----

googledrive::drive_auth(email = "acn.oliver.g.alexander@gmail.com",
                        cache = ".secrets")

googlesheets_name <- paste0(lubridate::today()," Test Sheet")

# NOTE: I think the sheet should be created beforehand
# googlesheets4::gs4_create(name = googlesheets_name,
#                           sheets = c("Participants", "Ambition", "Subcategories",
#                                      "Opportunities"))

# 
# sheet_dribble <- drive_get(googlesheets_name)
# 
# sheet_id <- as_sheets_id(sheet_dribble)
# sheet_id
