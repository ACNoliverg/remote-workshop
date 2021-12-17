category_mod_ui <- function(id){
  ns <- NS(id)
  tagList(
    div(class = "ui horizontal divider",
        ns("category")),
    div(class = "ui raised segment",
        grid(
          list(
            default = ns("g_temp"),
                 
                 ),
            header = h1(ns("category")),
            ns("description_list"),
            ns("choices_list"),
            ns("examples_list")
          )
        ))
    )}
category_mod <- function(id, category_frame) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    output$category <-
      category_frame$category[[1]]
    
    out$g_temp <- 
      construct_categoryTemplate(category_frame)
    
    #---- Name
    category_frame$subcategory %>% as.list() -> subcat_list
    names(subcat_list) <- paste0(subcat_list, "_nm")
 
    #---- Desc
    desc_list <- as.list(category_frame$description) %>%
                  map(renderText())
    names(desc_list) <-
      map(.x = category_frame$subcategory,
              .f = ~paste0(.x,"_desc"))
    out$description_list <- desc_list

    #-- Choice 
    choices <- map(category_frame$subcategory,
        ~dropdown_input(paste0(.x, "_choice"),
                               choices = c(
                                 "Not a priority",
                                 "Low priority",
                                 "Medium priority",
                                 "High priority"))) %>%
          tagList() %>%
      renderUI()
    
    names(choices) <- paste0(category_frame$subcategory,
                                  "_choice")
    output$choices_list <- choices
    
    #-- Example
    examples <- 
      rep("An example", 
          nrow(category_frame)) |>
      as.list() |>
        map(renderText)
    
    names(examples) <- paste0(category_frame$subcategory,
                                  "_ex")
    output$examples_list <- examples
  })
}

construct_categoryTemplate <-
  function(category_frame) {
    category_frame |>
      mutate(areas = map(.x = subcategory,
              .f = ~paste0(.x,
                           '_',
                         c("nm", "desc", "desc", "choice", "ex", "ex")
            ))) -> int
    
    areas_comp <- c(
      list(rep("head", 6)),
      c(int$areas)
    )
    grid_template(
      default = list(
        areas = rbind(areas_comp),
      )
    )
    return(template)}

test_mod <- function(cat_frame) {
  ui <- category_mod_ui("test")
  server <- category_mod("test",category_frame = cat_frame)
  
  shinyApp(ui, server)
}
test_mod(subcatInfo)

runApp(
  shinyApp(
    ui = category_mod_ui("test"),
    server = category_mod("test", subcatInfo)
  )
)
construct_categoryTemplate(subcatInfo)
# 