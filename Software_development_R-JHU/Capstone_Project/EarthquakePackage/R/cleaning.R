# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

library(tidyverse)
library(lubridate)

read_data <- function(path = 'EQdata.tsv') {
  data.frame(read.table(file = 'EQdata.tsv', sep = '\t', header=T))
}

clean_data <- function(data) {
  data <- data %>% select(Year, Mo, Dy, Location.Name, Mag, Latitude, Longitude, Deaths) %>%
          drop_na()

  data <- data %>% mutate(Date = make_date(Year, Mo, Dy)) %>%
          select(Date, Location.Name, Mag, Latitude, Longitude, Deaths, Year) %>%
          mutate(Location.Name = get_loc(Location.Name)) %>%
          mutate(Country = get_country(Location.Name))

  data
}

get_lc <- function(loc){
  loc <- tolower(loc)
  tools::toTitleCase(dplyr::last(strsplit(loc, ':')[[1]]))
}

get_cn <- function(loc) {
  loc <- tolower(loc)
  loc <- tools::toTitleCase(strsplit(loc, ':')[[1]][1])
  gsub(' ', '', loc, fixed = T)
}

get_country <- function(loc){
  lapply(loc, get_cn)
}

get_loc <- function(loc) {
  lapply(loc, get_lc)
}
