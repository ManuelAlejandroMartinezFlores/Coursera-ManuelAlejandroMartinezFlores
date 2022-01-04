geom_timeline_label <- function(
  mapping = NULL, data = NULL, stat = "identity",
  position = "identity", show.legend = NA, inherit.aes = TRUE,
  n_max = NULL, ..., na.rm = FALSE
) {
  ggplot2::layer(
    geom = GeomTimelineLabel,
    mapping = mapping, data = data, stat = stat,
    position = position, show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(n_max = n_max, na.rm = na.rm, ...)
  )
}

#' @rdname geom_timeline_label
#' @format NULL
#' @usage NULL
#'
#' @importFrom ggplot2 ggproto Geom draw_key_blank
#' @importFrom dplyr group_by top_n ungroup
#' @importFrom grid gpar linesGrob textGrob gList
GeomTimelineLabel <- ggplot2::ggproto(
  "GeomTimelineLabel", ggplot2::Geom,

  required_aes = c("x", "label"),


  default_aes  = ggplot2::aes(
    y             = 0.25,
    colour        = "black",
    size          = 1,
    alpha         = 0.25,
    shape         = 19,
    linesize      = 0.5,
    linetype      = 1,
    fontsize      = 10,
    stroke        = 1,
    angle         = 60,
    nmax          = 5
  ),

  draw_key = ggplot2::draw_key_blank,

  setup_data = function(data, params) {

    if (!("size" %in% colnames(data))) {
      warning(paste(
        "size is not provided.\n",
        "a random sample of points will be used"
      ))
      data$size <- sample.int(nrow(data))
    }



    if (!is.null(params$n_max)) {
      message(paste(params$n_max, "annotation will be drown."))
      data <- data %>%
        dplyr::group_by_("y") %>%
        dplyr::mutate(size_rank = dplyr::row_number(size)) %>%
        dplyr::top_n(params$n_max, size_rank) %>%
        dplyr::ungroup() %>%
        dplyr::select(-size_rank)
      print(data)
    }

    data
  },

  draw_panel = function(data, panel_scales, coord, n_max) {

    coords <- coord$transform(data, panel_scales)

    if (length(unique(coords$y)) == 1) {
      coords$y <-  0.25
    }

    if (!("size" %in% names(coords))) {
      coords$size <- 0.25
    }

    nmax <- coords$nmax[1]
    coords <- coords[order(coords$size)[1:nmax], ]

    n_grp  <- length(unique(data$y))
    offset <- 0.2 / n_grp

    lines <- grid::polylineGrob(
      x  = grid::unit(c(coords$x, coords$x), "npc"),
      y  = grid::unit(c(coords$y, coords$y + offset), "npc"),
      id = rep(seq_len(nrow(coords)), 2),
      gp = grid::gpar(
        col  = coords$colour,
        lwd  = grid::unit(coords$linesize, "mm"),
        lty  = coords$linetype
      )
    )



    names <- grid::textGrob(
      x     = grid::unit(coords$x, "npc"),
      y     = grid::unit(coords$y + offset, "npc"),
      label = coords$label,
      just  = c("left", "bottom"),
      rot   = 60,
      gp    = grid::gpar(
        col      = coords$colour,
        fontsize = grid::unit(coords$fontsize, "points")
      ),
      check.overlap = FALSE
    )

    grid::gList(lines, names)
  }
)

create_label <- function(df){
  df %>% mutate
}
