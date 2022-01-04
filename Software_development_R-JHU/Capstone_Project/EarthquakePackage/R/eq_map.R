eq_map <- function(.df, annot_col) {

  if (!all(
    c("Longitude", "Latitude", "Mag", annot_col) %in%
    names(.df)
  )) {
    stop(paste(
      "longitude, latitude, eq_primary, and", annot_col,
      "must be all present in the .df data provided.",
      "They don't. Please, provide correct data."
    ))
  }

  leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addCircleMarkers(
      lng    = .df[["Longitude"]],
      lat    = .df[["Latitude"]],
      radius = .df[["Mag"]],
      weight = 1,
      popup  = .df[[annot_col]]
    )
}
