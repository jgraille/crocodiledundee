source("data.R")

ui <- fluidPage(
  mainPanel(
    htmlOutput("text2"),
    echarts4rOutput("chart1"),
    echarts4rOutput("chart2"),
    echarts4rOutput("sentiment1"))
  
)

server <- function(input, output){
  e <- noisefrequency %>%
    e_charts(word) %>%
    e_radar(proportion, max = 0.06, name = 'tweets noise',areaStyle = list(opacity = .4)) %>%
    e_radar_opts(shape = 'circle') %>%
    e_tooltip(trigger='item') %>%
    e_title('tototototo')
  
  output$chart1 <- renderEcharts4r({
    e %>% e_theme_custom('{"title":{"text":"ceci est le titre"}}')
  })
  
  output$chart2 <- renderEcharts4r({
    CO2 %>%
      group_by(Plant) %>%
      e_charts(conc) %>%
      e_line(uptake,areaStyle = list(opacity = .4)) %>%
      e_mark_line(data=list(type="max")) %>%
      e_tooltip(trigger = "axis")
  })
  
  output$sentiment1 <- renderEcharts4r({
    head(noisefrequency,50) %>%
      group_by(sentiment) %>%
      e_charts(n) %>%
      e_line(n,areaStyle = list(opacity = .4)) %>%
      e_mark_line(data=list(type="max")) %>%
      e_tooltip(trigger = "axis")
  })
  
  output$text2 <- renderUI({
    str1 <- "Le lorem ipsum est, en imprimerie,\n 
             une suite de mots sans signification utilisée"
    str2 <- "valeur"
    str3 <- "🇺🇸"
    HTML(paste("hello", "world", str1, str2, str3, sep="<br/>"))
  })
}

shinyApp(ui, server)