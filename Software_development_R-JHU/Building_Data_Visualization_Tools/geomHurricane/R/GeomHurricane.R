

GeomHurricane <- ggplot2::ggproto("GeomHurricane",
                                  Geom,
                                  required_aes = c("x",     # x = longitude
                                                   "y",     # y = latitude
                                                   "r_ne",  # Northeast radius
                                                   "r_se",  # Southeast radius
                                                   "r_sw",  # Southwest radius
                                                   "r_nw"), # Northwest radius

                                  default_aes = ggplot2::aes(colour      = "black",  # Line color
                                                             fill        = "black",  # Standard Fill color
                                                             linetype    = 0,        # No line
                                                             alpha       = 0.65,     # Transparency
                                                             scale_radii = 1.0),     # Default value (no reduction)

                                  draw_key = draw_key_polygon,

                                  draw_group = function(data,
                                                        panel_scales,
                                                        coord) {
                                    # Creating a data frame
                                    df_hurricane <- dplyr::as_tibble()
                                    df_temp      <- dplyr::as_tibble()
                                    center       <- dplyr::as_tibble()

                                    # Adding new columns to de data
                                    data %>% dplyr::mutate(fill = fill,     # Creating columns to assign variables
                                                           colour = colour) #

                                    # Center of the hurricane
                                    data %>%
                                      dplyr::select(lon = x,           # longitude
                                                    lat = y) -> center # latitude

                                    # Calculating the area/radius
                                    data %>% dplyr::select(r_ne,       #
                                                           r_se,       # Subsetting
                                                           r_sw,       #
                                                           r_nw) %>%   #

                                      dplyr::mutate(r_ne = data$scale_radii * r_ne * 1852, # Converting nautical knots
                                                    r_se = data$scale_radii * r_se * 1852, # to meters : knots * 1852
                                                    r_sw = data$scale_radii * r_sw * 1852, # scale_radii : scale variable
                                                    r_nw = data$scale_radii * r_nw * 1852) -> radius

                                    # Loop to create the for quadrants (columns)
                                    for (i in 1:4)
                                    {
                                      # For each quadrant: Loop to create the 34, 50 and 64 knot areas (rows)
                                      for (j in 1:nrow(data))
                                      {
                                        # Generating the points
                                        geosphere::destPoint(c(x = center[j,1],      # Center of the "circle"
                                                               y = center[j,2]),     #
                                                             b = ((i-1)*90):(90*i),  # 360 degrees (a complete circle)
                                                             d = radius[j,i]) %>%    # radius

                                          rbind(c(x = center[j,1],       # Longitude
                                                  y = center[j,2])) %>%  # Latitude

                                          rbind(df_hurricane) -> df_hurricane # Output: Will be stacked over iteration
                                      }

                                      # Data Manipulation
                                      df_hurricane %>%

                                        dplyr::as_tibble() %>% # Converting to tibble

                                        dplyr::rename(x = lon,      # Renaming columns
                                                      y = lat) %>%  # The ouput of destPoint() function has lon and lat as names.

                                        coord$transform(panel_scales) -> quadrant_points # Cleaned data redy to plot
                                    }

                                    # Plot the polygon
                                    grid::polygonGrob(x = quadrant_points$x,   # Longitude
                                                      y = quadrant_points$y,   # Latitude
                                                      default.units = "native",
                                                      gp = grid::gpar(col = data$colour,  # Using line color given
                                                                      fill = data$fill,   # Using fill color given
                                                                      alpha = data$alpha, # Default value
                                                                      lty = 1,            # Default value
                                                                      scale_radii = data$scale_radii))   # scale_radii
                                  }
)
