rm(list = ls(all.names = TRUE))
#gc()

dependencies <- c("rtweet","dplyr","ggplot2","tidytext", "echarts4r", "shiny")

new.packages <- dependencies[!(dependencies %in% installed.packages()[,"Package"])]
if (length(new.packages)>0) install.packages(new.packages)

lapply(dependencies, library, character.only = TRUE)