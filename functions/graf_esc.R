graf_esc = function(table, output) {
  charts <- lapply(1:nrow(table), function(i) {
    output[[paste0("graf",i)]]  = renderHighchart({
      
      # Gráfico que se muestra para cada indicador
      hchart(object = table[i,], type = "bar", hcaes(x = indicador, y = valor), color ='red')
      
    })
  })
  
  tagList(
    lapply(seq_along(charts), function(i) {
      column(4,highchartOutput(paste0("graf",i)))
    })
  )
  
}

