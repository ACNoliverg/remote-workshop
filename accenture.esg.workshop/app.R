# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)


accenture.esg.workshop::run_app() # add parameters here (if any)

# Note: Parameters are probably going to be like the database connection!
#rsconnect::deployApp(appName="esg-workshop-dev")
