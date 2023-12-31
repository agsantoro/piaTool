ui_hpp = function (input) {
  renderUI({
    load("hpp/data/datosPais.RData")
    country = str_to_title(input$country)
    datosPais = datosPais %>% dplyr::filter(pais==country)
    
    nombres_input = c(
      "hpp_descuento",
      "hpp_costoIntervencion",
      "hpp_uso_oxitocina_base",
      "hpp_uso_oxitocina_taget" 
      
    )
    
    label_inputs = c(
      "Tasa de descuento (%)",
      "Costo programático de la intervención anual (USD)",
      "Cobertura actual del uso de oxitocina (%)",
      "Cobertura esperada del uso de oxitocina (%)"
    )
    
    inputs_hover = c(
      'Se utiliza para traer al presente los costos y beneficios en salud futuros',
      'Costo de implementar y sostener la intervención en un año (USD oficial a tasa de cambio nominal de cada país)',
      'Porcentaje de uso de oxitocina durante el parto en el país.',
      'Porcentaje de uso de oxitocina durante el parto en el país luego de la intervención'
    )
    
    porcentajes = c(1,3,4)
    
    if (is.null(input$country) == F) {
      hpp_map_inputs = data.frame(
        intervencion = "Hemorragia postparto",
        i_names = nombres_input,
        i_labels = label_inputs
      )
      
      hpp_map_inputs$avanzado = NA
      hpp_map_inputs$avanzado[1:3] = T
      hpp_map_inputs$avanzado[4] = F
      
      rownames(hpp_map_inputs) = 1:nrow(hpp_map_inputs)
      
      save(
        hpp_map_inputs,
        file = "hpp_map_inputs.Rdata"
      )
      
    }
    
    defaults = c(
      0.05,
      0,
      datosPais$value[4],
      .80339
    )
    
    tagList(
      
          lapply(4, function(i) {
            sliderInput(
              nombres_input[i],
              tags$div(
                label_inputs[i],
                icon("circle-info",
                     "fa-1x",
                     title = inputs_hover[i])
              ),
              min = 0,
              max = 100,
              defaults[i]*100)
          }),
          tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                      tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Avanzado")),
                      actionLink(inputId = "toggle_avanzado_hpp", label=icon("stream", style = "color: white;"))
          ),
        
          lapply(1:3, function(i) {
            if (i %in% porcentajes) {
              hidden(sliderInput(nombres_input[i],
                                 tags$div(
                                   label_inputs[i],
                                   icon("circle-info",
                                        "fa-1x",
                                        title = inputs_hover[i])
                                 ),
                                 min=0,
                                 max=100,
                                 defaults[i]*100))
            } else {
              hidden(numericInput(nombres_input[i],tags$div(
                label_inputs[i],
                icon("circle-info",
                     "fa-1x",
                     title = inputs_hover[i])
              ),defaults[i]))
            }
            
          })    
        )
      
      
    
    
  })
  
  
  
  
}


ui_resultados_hpp = function(input,output,resultados) {
  
  hpp_run = resultados()
  
  output$hpp_summaryTable = renderReactable({
    
    if (length(hpp_run)>1) {
      table = hpp_run
      table$Valor = format(round(table$Valor,1),big.mark = ".",decimal.mark = ",")
      
      cat_epi = c(2,4:8)
      cat_costos = c(1,3, 9:12)
      
      table$cat=""
      table$cat[cat_epi] = "Resultados epidemiológicos"
      table$cat[cat_costos] = "Resultados económicos"
      reactable(
        table,
        groupBy = "cat",
        defaultExpanded = T,
        pagination = F,
        defaultColDef = colDef(
          align = "center",
          minWidth = 70,
          headerStyle = list(background = "#236292", color = "white")
        ),
        columns = list(
          cat = colDef(name = "Categoría", align = "left"),
          Indicador = colDef(name = "Indicador", align = "left"),
          Valor = colDef(name = "Valor", align = "right")
        ),
        bordered = TRUE,
        highlight = TRUE
      )
    }
    
  })
  
  tagList(
    reactableOutput("hpp_summaryTable")
  )
  
}


