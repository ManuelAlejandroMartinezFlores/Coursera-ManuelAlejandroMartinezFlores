library(tidyr)
library(geosphere)

geom_beta <- function(df, radii=1){

  df <- df %>% mutate(ne = ne*radii*1852, nw = nw*radii*1852, se=se*radii*1852, sw=sw*radii*1852)
  ne <- data.frame(destPoint(c(df$lon[1], df$lat[1]), b=0:90, d=df$ne[1])) %>%
    rbind(c(df$lon[1], df$lat[1]))
  se <- data.frame(destPoint(c(df$lon[1], df$lat[1]), b=90:180, d=df$se[1])) %>%
    rbind(c(df$lon[1], df$lat[1]))
  sw <- data.frame(destPoint(c(df$lon[1], df$lat[1]), b=180:270, d=df$sw[1])) %>%
    rbind(c(df$lon[1], df$lat[1]))
  nw <- data.frame(destPoint(c(df$lon[1], df$lat[1]), b=270:360, d=df$nw[1])) %>%
    rbind(c(df$lon[1], df$lat[1]))

  pol <- ggplot() + geom_polygon(data = ne, aes(lon, lat, fill = df$wind_speed[1], alpha = 0.5))
  pol <- pol + geom_polygon(data = nw, aes(lon, lat, fill = df$wind_speed[1], alpha = 0.5))
  pol <- pol + geom_polygon(data = sw, aes(lon, lat, fill = df$wind_speed[1], alpha = 0.5))
  pol <- pol + geom_polygon(data = se, aes(lon, lat, fill = df$wind_speed[1], alpha = 0.5))

  ne <- data.frame(destPoint(c(df$lon[2], df$lat[2]), b=0:90, d=df$ne[2])) %>%
    rbind(c(df$lon[2], df$lat[2]))
  se <- data.frame(destPoint(c(df$lon[2], df$lat[2]), b=90:180, d=df$se[2])) %>%
    rbind(c(df$lon[2], df$lat[2]))
  sw <- data.frame(destPoint(c(df$lon[2], df$lat[2]), b=180:270, d=df$sw[2])) %>%
    rbind(c(df$lon[2], df$lat[2]))
  nw <- data.frame(destPoint(c(df$lon[2], df$lat[2]), b=270:360, d=df$nw[2])) %>%
    rbind(c(df$lon[2], df$lat[2]))

  pol <- pol + geom_polygon(data = ne, aes(lon, lat, fill = df$wind_speed[2], alpha = 0.5))
  pol <- pol + geom_polygon(data = nw, aes(lon, lat, fill = df$wind_speed[2], alpha = 0.5))
  pol <- pol + geom_polygon(data = sw, aes(lon, lat, fill = df$wind_speed[2], alpha = 0.5))
  pol <- pol + geom_polygon(data = se, aes(lon, lat, fill = df$wind_speed[2], alpha = 0.5))


  ne <- data.frame(destPoint(c(df$lon[3], df$lat[1]), b=0:90, d=df$ne[3])) %>%
    rbind(c(df$lon[3], df$lat[3]))
  se <- data.frame(destPoint(c(df$lon[3], df$lat[3]), b=90:180, d=df$se[3])) %>%
    rbind(c(df$lon[3], df$lat[3]))
  sw <- data.frame(destPoint(c(df$lon[3], df$lat[3]), b=180:270, d=df$sw[3])) %>%
    rbind(c(df$lon[3], df$lat[3]))
  nw <- data.frame(destPoint(c(df$lon[3], df$lat[3]), b=270:360, d=df$nw[3])) %>%
    rbind(c(df$lon[3], df$lat[3]))

  pol <- pol + geom_polygon(data = ne, aes(lon, lat, fill = df$wind_speed[3], alpha = 0.5))
  pol <- pol + geom_polygon(data = nw, aes(lon, lat, fill = df$wind_speed[3], alpha = 0.5))
  pol <- pol + geom_polygon(data = sw, aes(lon, lat, fill = df$wind_speed[3], alpha = 0.5))
  pol <- pol + geom_polygon(data = se, aes(lon, lat, fill = df$wind_speed[3], alpha = 0.5))
  pol

}


