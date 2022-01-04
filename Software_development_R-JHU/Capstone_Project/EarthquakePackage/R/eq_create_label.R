eq_create_label <- function(.df) {

  location  <- stringr::str_c(
    "<strong>Location: </strong>", .df$Location.Name
  ) %>% stringr::str_replace_na("")

  magnitude <- stringr::str_c(
    "<br><strong>Magnitude: </strong>", .df$Mag
  ) %>% stringr::str_replace_na("")


  deaths <- stringr::str_c(
    "<br><strong>Total deaths: </strong>", .df$Deaths
  ) %>% stringr::str_replace_na("")

  stringr::str_c(location, magnitude, deaths)
}
