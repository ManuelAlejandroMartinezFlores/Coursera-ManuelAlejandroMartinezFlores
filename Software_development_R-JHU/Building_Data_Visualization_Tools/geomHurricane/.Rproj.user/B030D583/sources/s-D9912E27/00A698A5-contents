library(png)
test <- function(){
  base_map <- map_data('world') %>% filter(long > -100) %>% filter (long < -80) %>% filter(lat < 35) %>%
     filter(lat > 15) %>% ggplot() + geom_path(aes(long, lat, group=group))
  d_test = data_manipulation(data_import())
  base_map +
    geom_hurricane(data = d_test, aes(x=lon, y=lat, r_ne=ne, r_se=se, r_sw=sw, r_nw=nw,
                                      fill=wind_speed, color=wind_speed)) +
    scale_color_manual(name = 'Wind speed (kts)',
                       values = c('red', 'orange', 'yellow')) +
    scale_fill_manual(name = 'Wind speed (kts)',
                       values = c('red', 'orange', 'yellow')) +
    labs(title = 'IKE - 2008-09-11-18:00:00')
}

write_assigment <- function(){
  png(filename = 'final_assigment_r_vis.png')
  test()
  print('ok')
  dev.off()
}
