library(ggplot2)
library(grid)

required_aes = c('x')

optional_aes = c('y',
                 'colour',
                 'size',
                 'alpha')

default_aes = c(pch = 21,
                colour = 'black',
                size = 0.01,
                fill = 'grey',
                alpha = 0.4,
                stroke = 1)

draw_panel <- function(data, panel_params, coord){

  data$size <- data$size/max(data$size)

  coords <- coord$transform(data, panel_params)

  circleGrob(coords$x,
             coords$y,
             r = coords$size/25,
             gp = gpar(col = scales::alpha(coords$colour, coords$alpha),
                       fill = scales::alpha(coords$colour, coords$alpha),
                       alpha = coords$alpha,
                       fontsize = coords$size,
                       lwd = coords$stroke))
}

GeomTimeline <- ggplot2::ggproto(`_class`     = "GeomTimeline",
                                 `_inherit`   = ggplot2::Geom,
                                 required_aes = required_aes,
                                 optional_aes = optional_aes,
                                 default_aes  = default_aes,
                                 draw_key     = ggplot2::draw_key_point,
                                 draw_panel   = draw_panel)
