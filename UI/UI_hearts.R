ui_hearts = function (input,base_line) {
  browser
  
  country_sel = str_to_title(input$country)
  
  renderUI({
  
    input_names = c(
      "Prevalencia de hipertensión entre adultos de 30-79 años, estandarizada por edad",
      "Prevalencia de diagnóstico previo de hipertensión entre adultos de 30-79 años con hipertensión, estandarizada por edad.",
      "Tratamiento entre diagnosticados (%)",
      "Control de la hipertensión entre los tratados (%)"
    )
    names(input_names) = colnames(base_line)[2:5]
    
    tagList(
      bsCollapse(
        id="hearts_collapse",
        open="Parámetros básicos",
        bsCollapsePanel(
          
          title = "Parámetros básicos",
          h4("Línea de base"),
          lapply(input_names[3], function (i) {
            
            sliderInput(paste0("hearts_input_base_",which(input_names==i)),
                        input_names[input_names==i],
                        value = base_line[base_line$country==country_sel,names(input_names[input_names==i])],
                        min=0,
                        max=1,
                        step=.001)
          }),
          h4("Objetivo"),
          lapply(input_names[3], function (i) {
            sliderInput(paste0("hearts_input_target_",which(input_names==i)),
                        input_names[input_names==i],
                        value = targets_default[targets_default$country==country_sel,names(input_names[input_names==i])],
                        min=0,
                        max=1,
                        step=.001)
          })),
        bsCollapsePanel(
          title = "Parámetros Avanzados",
          h4("Línea de base"),
          lapply(input_names[c(1,2,4)], function (i) {
            
            sliderInput(paste0("hearts_input_base_",which(input_names==i)),
                        input_names[input_names==i],
                        value = base_line[base_line$country==country_sel,names(input_names[input_names==i])],
                        min=0,
                        max=1,
                        step=.001)
          }),
          h4("Objetivo"),
          lapply(input_names[c(1,2,4)], function (i) {
            sliderInput(paste0("hearts_input_target_",which(input_names==i)),
                        input_names[input_names==i],
                        value = targets_default[targets_default$country==country_sel,names(input_names[input_names==i])],
                        min=0,
                        max=1,
                        step=.001)
          })
        ))
      
    )
    
    
  })
}