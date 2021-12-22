create_subcategoryDT <- function(dt) {
  dt |>
    select(Subcategory, Opportunity, Year, net) |>
    # Spread 
    pivot_wider(names_from = Year,
                values_from = net,
                names_prefix = "year_")
}