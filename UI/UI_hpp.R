ui_hpp = function (input) {
  renderUI({
    load("hpp/data/datosPais.RData")
    country = str_to_title(input$country)
    datosPais = datosPais %>% dplyr::filter(pais==country)
    
    nombres_input = c(
      "hpp_uso_oxitocina_base",
      "hpp_uso_oxitocina_taget",
      "hpp_partos_anuales",
      "hpp_edad_parto",
      "hpp_partos_institucionales",
      "hpp_mortalidad_materna",
      "hpp_mortalidad_hpp",
      "hpp_pHPP",
      "hpp_pHPP_Severa",
      "hpp_pHisterectomia",
      "hpp_eficaciaOxitocina",  
      "hpp_uHisterectomia",
      "hpp_costo_oxitocina",
      "hpp_costo_programatico",
      "hpp_tasa_descuento",
      "hpp_costo_no_severa",
      "hpp_costo_severa"
    )
    
    label_inputs = c(
      'Cobertura actual del uso de oxitocina (%)',
      'Cobertura esperada del uso de oxitocina (%)',
      'Partos anuales (n)',
      'Edad promedio al parto',
      'Partos institucionales (%)',
      'Mortalidad materna',
      'Mortalidad materna por hemorragia postparto (%)',
      'Riesgo de hemorragia postparto sin profilaxis (%)',
      'Riesgo de hemorragia postparto severa dada una hemorragia postparto (%)',
      'Riesgo de histerectomía dada una hemorragia postparto severa (%)',
      'Riesgo Relativo de hemorragia postparto con oxitocina',
      'Años de vida ajustados por calidad por  histerectomía',
      'Costo de oxitocina (USD)',
      'Costo programático de anual de la intervención (USD)',
      'Tasa de descuento (%)',
      'Costo de episodio de hemorragia postparto no severa',
      'Costo de episodio de hemorragia postparto severa'
    )
    
    
    inputs_hover = c(
      'Porcentaje de uso de oxitocina durante el parto en el país',
      'Porcentaje de uso de oxitocina durante el parto en el país luego de la intervención',
      'Número de partos registrados en el país por año',
      'Edad materna promedio en el momento del parto en el país',
      'Porcentaje de partos institucionales para el país',
      'Número de muertes maternas por cada 100.000 partos en el país',
      'Porcentaje de muertes maternas atribuibles a HPP en el país',
      'Porcentaje de que al momento del parto se presente una hemorragia postparto (≥500 ml) en ausencia de intervención profiláctica',
      'Porcentaje condicional estimado de que ocurra una hemorragia postparto severa (≥1000 ml) después de haber experimentado una hemorragia postparto',
      'Porcentaje estimado de que una mujer que experimenta una hemorragia postparto severa requiera una histerectomía como resultado de esta complicación',
      'Riesgo relativo de desarrollar hemorragia postparto en pacientes que recibieron oxitocina en comparación con aquellos que no la recibieron',
      'Utilidad de vivir un año con una histerectomía',
      'Costo de 10 UI de oxitocina en el país para julio 2023 (USD oficial a tasa de cambio nominal de cada país)',
      'Costo de implementar y sostener la intervención en un año (USD oficial a tasa de cambio nominal de cada país)',
      'Se utiliza para traer al presente los costos y beneficios en salud futuros',
      'Costo de hemorragia post parto no severa (< 1000 ml) en el país para julio 2023',
      'Costo de hemorragia post parto severa (≥1000 ml) en el país para julio 2023'
    )
    
    datosPais = read_xlsx("hpp/data/datosPais.xlsx")
    datosPais = datosPais[datosPais$pais==str_to_title(input$country),]
    
    input_values = c(
      round(datosPais$value[datosPais$indicador=="PARTOS.ANUALES"] * datosPais$value[datosPais$indicador=="USO.DE.OXITOCINA"] /(datosPais$value[datosPais$indicador=="PARTOS.ANUALES"]*datosPais$value[datosPais$indicador=="pINSTITUCIONALES"]),5), 
      round(datosPais$value[datosPais$indicador=="PARTOS.ANUALES"] * datosPais$value[datosPais$indicador=="USO.DE.OXITOCINA"] /(datosPais$value[datosPais$indicador=="PARTOS.ANUALES"]*datosPais$value[datosPais$indicador=="pINSTITUCIONALES"]),5)*1.2, 
      datosPais$value[datosPais$indicador=="PARTOS.ANUALES"],
      datosPais$value[datosPais$indicador=="EDAD.AL.PARTO"],
      datosPais$value[datosPais$indicador=="pINSTITUCIONALES"],
      datosPais$value[datosPais$indicador=="MORTALIDAD.MATERNA"],
      datosPais$value[datosPais$indicador=="pMORTALIDAD.MATERNA.POR.HPP"],
      0.108,
      0.1759,
      0.03,
      0.51,
      0.985,
      datosPais$value[datosPais$indicador=="COSTO.Oxitocina"],
      0,
      0.05,
      datosPais$value[datosPais$indicador=="COSTO.mHPP"],
      datosPais$value[datosPais$indicador=="COSTO.sHPP"]
    )
    
    bsc = c(1,2)
    avz = c(3:length(input_values))
    porcentajes = c(1,2,5,7,8,9,10,11,15)
    
    if (is.null(input$country) == F) {
      hpp_map_inputs = data.frame(
        intervencion = "Hemorragia postparto",
        i_names = nombres_input,
        i_labels = label_inputs
      )
      
      hpp_map_inputs$avanzado = NA
      hpp_map_inputs$avanzado[avz] = T
      hpp_map_inputs$avanzado[bsc] = F
      
      rownames(hpp_map_inputs) = 1:nrow(hpp_map_inputs)
      
      save(
        hpp_map_inputs,
        file = "hpp_map_inputs.Rdata"
      )
      
    }
    
    tagList(
      
          lapply(bsc, function(i) {
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
              step = 0.01,
              input_values[i]*100)
          }),
          tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                      tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Avanzado")),
                      actionLink(inputId = "toggle_avanzado_hpp", label=icon("stream", style = "color: white;"))
          ),
        
          lapply(avz, function(i) {
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
                                 step = 0.01,
                                 input_values[i]*100))
            } else {
              hidden(numericInput(nombres_input[i],tags$div(
                label_inputs[i],
                icon("circle-info",
                     "fa-1x",
                     title = inputs_hover[i])
              ),input_values[i]))
            }
            
          })    
        )
      
      
    
    
  })
  
  
  
  
}


ui_resultados_hpp = function(input,output,resultados) {
  
  hpp_run = resultados()
  
  
  output$hpp_grafico = renderUI({
    if (length(hpp_run)>1) {
      indicadores = c(
        'Años de vida ajustados por discapacidad evitados',
        'Costo total de la intervención (USD)',
        'Diferencia de costos respecto al escenario basal (USD)',
        'Retorno de Inversión (%)',
        'Razón de costo-efectividad incremental por Año de Vida Ajustado por Discapacidad evitado (USD)'
      )
      
      table = hpp_run[hpp_run$indicador %in% indicadores, c("indicador","valor")]
      
      graf_esc(table, output)
    }
  })
  
  output$hpp_summaryTable = renderReactable({
    
    if (length(hpp_run)>1) {
      table = hpp_run
      rownames(table) = 1:nrow(table)
      
      table$valor = format(round(as.numeric(table$valor),1),big.mark = ".",decimal.mark = ",")
      
      table$valor_desc[is.na(table$valor_desc)==F] = format(round(as.numeric(table$valor_desc[is.na(table$valor_desc)==F]),1),big.mark = ".",decimal.mark = ",")
      
      table$valor_desc[is.na(table$valor_desc)] = "-"
      
      cat_epi = 1:4
      cat_costos = 4:nrow(table)
      
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
          indicador = colDef(name = "Indicador", align = "left"),
          valor = colDef(name = "Valor sin descontar", align = "right"),
          valor_desc = colDef(name = "Valor descontado", align = "right")
        ),
        bordered = TRUE,
        highlight = TRUE
      )
    }
    
  })
  
  tagList(
    fluidRow(
      column(12,
             uiOutput("hpp_grafico")
             ),
      column(12,
             reactableOutput("hpp_summaryTable"))
    )
  )
  
}


