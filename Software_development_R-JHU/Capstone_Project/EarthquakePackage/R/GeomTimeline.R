#' Time line of earthquakes
#'
#' \code{geom_timeline} return a \code{\link[ggplot2]{layer}}
#'     representing a time line of earthquakes, i.e. a time line over
#'     which there are a point for each earthquake.
#'
#' @details Aesthetics:
#' \code{geom_timeline} understands the following aesthetics
#'   (required in bold):
#' \itemize{
#'   \item \strong{x}: (Date) of earthquakes
#'   \item y: (factr) stratification. If present multiple time lines
#'            will be plotted for each level of the factor
#'            (e.g. country).
#'   \item colour: of the points
#'   \item size: of the points
#'   \item alpha: trasparency for the points
#'   \item fill
#'   \item linetype
#'   \item linesize
#'   \item fontsize
#'   \item stroke
#' }
#'
#' @inheritParams ggplot2::layer
#' @param na.rm (lgl, default = FALSE) remove missing data?
#' @param ... further arguments passed to the geom layer
#'
#' @importFrom ggplot2 layer
#'
#' @export
#' @examples
#' \dontrun{
#'     library(dplyr)
#'     library(lubridate)
#'     library(ggplot2)
#'
#'     library(devrcap)
#'         data(noaa)
#'
#'     noaa %>%
#'         eq_clean_data() %>%
#'         filter(
#'             country %in% c("ITALY", "GREECE", "PORTUGAL"),
#'             year(date) >= 1900
#'         ) %>%
#'         ggplot(aes(
#'             x = date,
#'             y = country,
#'             size   = eq_primary,
#'             colour = log(total_deaths)
#'         )) +
#'         geom_timeline()
#' }
geom_timeline <- function(
  mapping = NULL, data = NULL, stat = "identity",
  position = "identity", show.legend = NA, inherit.aes = TRUE,
  ..., na.rm = FALSE
) {
  ggplot2::layer(
    geom = GeomTimeline, mapping = mapping, data = data,
    stat = stat, position = position, show.legend = show.legend,
    inherit.aes = inherit.aes, params = list(na.rm = na.rm, ...)
  )
}


#' @rdname geom_timeline
#' @format NULL
#' @usage NULL
#'
#' @importFrom ggplot2 ggproto Geom aes draw_key_point
#' @importFrom grid pointsGrob unit gpar polylineGrob gList
#' @importFrom scales alpha
#'
#' @export
GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::Geom,

                                 required_aes = c("x"),

                                 default_aes = ggplot2::aes(

                                   y        = 0.25,
                                   colour   = "grey",
                                   size     = 1,
                                   alpha    = 0.2,
                                   shape    = 19,
                                   fill     = "black",
                                   linesize = 0.5,
                                   linetype = 1 ,
                                   fontsize = 10,
                                   stroke   = 1
                                 ),

                                 draw_key = ggplot2::draw_key_point,

                                 setup_data = function(data, params) {

                                   if ("colour" %in% colnames(data)) {
                                     warning(paste(
                                       "missing values for colour.",
                                       "They were replaced with the minimum value."
                                     ))
                                     data$colour[is.na(data$colour)] <-
                                       min(data$colour, na.rm = TRUE)
                                   }
                                   data
                                 },

                                 draw_panel = function(data, panel_scales, coord) {
                                   coords <- data %>%
                                     coord$transform(panel_scales)

                                   if (length(unique(coords$y)) == 1) {
                                     coords$y <- 0.25
                                   }

                                   points <- grid::pointsGrob(
                                     x    = coords$x,
                                     y    = coords$y,
                                     size = grid::unit(coords$size * 0.3, "char"),
                                     pch  = coords$shape,
                                     gp   = grid::gpar(
                                       col      = coords$colour %>%
                                         scales::alpha(coords$alpha),
                                       fill     = coords$fill %>%
                                         scales::alpha(coords$alpha),
                                       fontsize = grid::unit(coords$fontsize, "points")
                                     )
                                   )

                                   y_lines <- unique(coords$y)

                                   lines <- grid::polylineGrob(
                                     x  = grid::unit(
                                       rep(c(0, 1), each = length(y_lines)),
                                       "npc"
                                     ),
                                     y  = grid::unit(c(y_lines, y_lines), "npc"),
                                     id = rep(seq_along(y_lines), 2),
                                     gp = grid::gpar(
                                       col = "grey",
                                       lwd = grid::unit(coords$linesize[1], "mm")
                                     )
                                   )

                                   grid::gList(points, lines)
                                 }
)
