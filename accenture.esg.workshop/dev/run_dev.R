# Set options here
options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode

# Detach all loaded packages and clean your environment
library(shiny)
library(reactlog)
reactlog::reactlog_enable()
options(shiny.reactlog = TRUE)
options(int)
golem::detach_all_attached()
golem::document_and_reload()

library(shiny)
library(reactlog)
reactlog::reactlog_enable()
options(shiny.reactlog = TRUE)
run_app()