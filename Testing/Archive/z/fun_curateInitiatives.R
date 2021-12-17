require(tidyverse)
curateInitiatives <- function(initiatives_db, choices_list) {
  
  ambition <- choices_list$ambition
  priorities <- choices_list$priorities
  timeframes <- choices_list$timeframes
 
  initiatives_db %>%
    filter(Ambition == ambition,
           ESG %in% priorities,
           Timeframe == timeframes )
  
}