# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency
#-- Shiny packages

usethis::use_package("rsconnect")
usethis::use_package( "shiny" ) # TODO: Figure out which need {remotes} to install
usethis::use_package("shiny.semantic")
usethis::use_package("semantic.dashboard")
usethis::use_package("shinipsum")
usethis::use_dev_package("fakir", remote = "https://github.com/ThinkR-open/fakir")
#-- For databases / connections
usethis::use_package("dplyr",)
usethis::use_package("dbplyr")
usethis::use_package("pool")
usethis::use_package("reactlog")


## Add modules ----
## Create a module infrastructure in R/
golem::add_module( name = "main" ) # Name of the module
golem::add_module( name = "1000_create_workshop" ) # Name of the module
golem::add_module( name = "new_mod" ) # Name of the module


golem::add_module( name = "1100_initiate_databases")
golem::add_fct("mongo", module = "1100_initiate_databases")

## Add helper functions ----
## Creates fct_* and utils_*
golem::add_fct( "helpers" )
golem::add_utils( "helpers",)
golem::add_utils("database")

golem::browser_button()
## External resources
## Creates .js and .css files at inst/app/www
golem::add_js_file( "script" )
golem::add_js_handler( "handlers" )
golem::add_css_file( "load_workflow" )

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw( name = "my_dataset", open = FALSE ) 

## Tests ----
## Add one line by test you want to create
usethis::use_test( "app" )

# Documentation

## Vignette ----
usethis::use_vignette("accenture.esg.workshop")
devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
covrpage::covrpage()

## CI ----
## Use this part of the script if you need to set up a CI
## service for your application
## 
## (You'll need GitHub there)
usethis::create_github_token()
gitcreds::gitcreds_set(url = "https://github.com/ACNoliverg")

usethis::use_github(host = "https://github.com/ACNoliverg/remote-workshop.git",
                    protocol = "https"
                    )
usethis::gh_token_help()

# GitHub Actions

# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
# usethis::use_github_action("shiny-deploy")
# usethis::use_github_action_check_release() 
# usethis::use_github_action_check_standard() 
# usethis::use_github_action_check_full() 
# # Add action for PR
# ?usethis::use_github_action_pr_commands()

# usethis::git_sitrep()
# 
# # Travis CI
# usethis::use_travis() 
# usethis::use_travis_badge() 
# 
# # AppVeyor 
# usethis::use_appveyor() 
# usethis::use_appveyor_badge()
# 
# # Circle CI
# usethis::use_circleci()
# usethis::use_circleci_badge()
# 
# # Jenkins
# usethis::use_jenkins()
# 
# # GitLab CI
# usethis::use_gitlab_ci()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")



# rsconnect::deployDoc(id = 4672840)

