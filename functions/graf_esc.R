graf_esc = function(table, output) {
  charts <- lapply(1:nrow(table), function(i) {
    output[[paste0("graf",i)]]  = renderHighchart({
      
      # Gráfico que se muestra para cada indicador
      
      
      hchart(object = table[i,], type = "bar", hcaes(x = indicador, y = valor)) %>%
        hc_colors(colors = c("#339BDF")) %>%
        hc_plotOptions(series = list(pointWidth = 50, borderColor = 'black', borderWidth = 1)) %>%  # Agrega borde a la barra
        hc_title(text = table[i,1]) %>%
        hc_xAxis(title = list(text = ""), labels = list(enabled = FALSE)) %>% 
        hc_yAxis(title = list(text = "Valor"), labels = list(enabled = TRUE), 
                 plotLines = list(list(color = "black", width = 3, value = 0))) %>% 
        hc_tooltip(pointFormat = 'Valor: {point.y:.1f}') %>% 
        hc_add_theme(hc_theme_hcrt())  # Aplica el tema 'hcrt'
      
    })
  })
  
  tagList(
    lapply(seq_along(charts), function(i) {
      column(4,highchartOutput(paste0("graf",i)))
    })
  )
  
}

