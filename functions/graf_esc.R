graf_esc = function(table, output) {
  charts <- lapply(1:nrow(table), function(i) {
    output[[paste0("graf",i)]]  = renderHighchart({
      
      # Gráfico que se muestra para cada indicador
      
      hchart(object = table[i,], type = "bar", hcaes(x = indicador, y = valor)) %>%
        hc_colors(colors = c("#339BDF")) %>%
        hc_plotOptions(series = list(pointWidth = 50, borderColor = 'black',
                                     borderWidth = 1,
                                     groupPadding = -1,  # Reduce el padding entre grupos de barras
                                     pointPadding = -4
                                     )) %>%  
        hc_title(text = table[i,1], style = list(fontSize = '15px')) %>%
        hc_xAxis(title = list(text = ""), labels = list(enabled = FALSE),
                 startOnTick = FALSE, endOnTick = FALSE) %>% 
        hc_yAxis(title = list(text = "Valor"), labels = list(enabled = TRUE),
                 plotLines = list(list(color = "black", width = 3, value = 0))) %>% 
        hc_tooltip(pointFormat = 'Valor: {point.y:.1f}') %>% 
        hc_size(height= 220) %>% 
        #hc_chart(margin = c(10, 10, 10, 3)) %>%  # Ajusta los márgenes del gráfico
        hc_add_theme(hc_theme_hcrt())  # Aplica el tema 'hcrt'
      
    })
  })
  
  tagList(
    lapply(seq_along(charts), function(i) {
      column(4,highchartOutput(paste0("graf",i)))
    })
  )
  
}

