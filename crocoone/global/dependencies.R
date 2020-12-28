rm(list = ls(all.names = TRUE))
dependencies <- c("rtweet","dplyr","ggplot2",
                  "tidytext", "echarts4r", "shiny","here")
cranMirror <- "https://ftp.gwdg.de/pub/misc/cran/"
new.packages <- dependencies[!(dependencies %in% installed.packages()[,"Package"])]
if (length(new.packages)>0) install.packages(new.packages,repos = "https://ftp.fau.de/cran/")
lapply(dependencies, require, character.only = TRUE)
