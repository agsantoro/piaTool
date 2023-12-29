ui_hepC = function (input, datosPais) {
  
  country_sel = str_to_title(input$country)
  
  renderUI({
    input_names = c(
      'Costo de cirrosis descompensada (USD)' = "aCostoDC", 
      'Costos de estadío de fibrosis F0 a F2 (USD)' = "aCostoF0F2", 
      'Costos de estadío de fibrosis F3 (USD)' = "aCostoF3", 
      'Costos de estadío de fibrosis F4 (USD)' = "aCostoF4", 
      'Costos de carcinoma hepatocelular (USD)' = "aCostoHCC", 
      'Tasa de descuento (%)' = "AtasaDescuento", 
      'Tamaño de la cohorte (n)' = "cohorte", 
      'Costo de la evaluación de la respuesta al tratamiento' = "Costo_Evaluacion", 
      'Costo de tratamiento mensual con Sofosbuvir/ Velpatasvir (Epclusa®) (USD)' = "Costo_Tratamiento",
      'Porcentaje de personas en estadío de fibrosis F0 al diagnóstico (%)' = "F0", 
      'Porcentaje de personas en estadío de fibrosis F1 al diagnóstico (%)' = "F1", 
      'Porcentaje de personas en estadío de fibrosis F2 al diagnóstico (%)' = "F2", 
      'Porcentaje de personas en estadío de fibrosis F3 al diagnóstico (%)' = "F3", 
      'Porcentaje de personas en estadío de fibrosis F4 al diagnóstico (%)' = "F4", 
      'Porcentaje de pacientes que abandonan el tratamiento (%)' = "pAbandono", 
      'Eficacia de Sofosbuvir/ Velpatasvir (Epclusa®) (%)' = "pSVR", 
      'Duración del tratamiento (meses)' = "tDuracion_Meses"
    )
    
    inputs_hover = c(
      'Costo de cirrosis descompensada (USD)',
      'Costos de estadío de fibrosis F0 a F2 (USD)',
      'Costos de estadío de fibrosis F3 (USD)',
      'Costos de estadío de fibrosis F4 (USD)',
      'Costos de carcinoma hepatocelular (USD)',
      'Se utiliza para traer al presente los costos y beneficios en salud futuros',
      'Número de personas mayores de 18 años con infección por VHC que ingresan al modelo',
      'Costo de la evaluación de la respuesta al tratamiento',
      'Costo de tratamiento mensual de Sofosbuvir/ Velpatasvir (Epclusa®) para julio de 2023. Régimen de AAD (antivirales de acción directa) de 4 semanas. (USD oficial a tasa de cambio nominal de cada país)',
      'Porcentaje de personas en estadío de fibrosis F0 al diagnóstico',
      'Porcentaje de personas en estadío de fibrosis F1 al diagnóstico',
      'Porcentaje de personas en estadío de fibrosis F2 al diagnóstico',
      'Porcentaje de personas en estadío de fibrosis F3 al diagnóstico',
      'Porcentaje de personas en estadío de fibrosis F4 al diagnóstico',
      'Porcentaje de pacientes que abandonan el tratamiento',
      'Porcentaje de la capacidad del tratamiento antiviral específico que combina los medicamentos Sofosbuvir y Velpatasvir para eliminar o reducir la carga viral del VHC',
      'Duración del tratamiento con Sofosbuvir (400 mg) y Velpatasvir (100 mg) en meses'
    )
    
    porcentajes = c(6,10:16)
    
    
    default = list()
    default$cohorte = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="Cohorte"]
    default$AtasaDescuento = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="Descuento"]
    default$F0 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="F0"]
    default$F1 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="F1"]
    default$F2 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="F2"]
    default$F3 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="F3"]
    default$F4 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="CC"]
    default$aCostoF0F2 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="costos" & datosPais$indicador=="F0-F2"]
    default$aCostoF3 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="costos" & datosPais$indicador=="F3"]
    default$aCostoF4 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="costos" & datosPais$indicador=="F4"]
    default$aCostoDC = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="costos" & datosPais$indicador=="DC"]
    default$aCostoHCC = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="costos" & datosPais$indicador=="HCC"]
    default$pSVR = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="tratamiento" & datosPais$indicador=="SVR"]
    default$tDuracion_Meses = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="tratamiento" & datosPais$indicador=="Duracion Meses"]
    default$pAbandono = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="tratamiento" & datosPais$indicador=="%Abandono"]
    default$Costo_Tratamiento = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="costos" & datosPais$indicador=="Costo Mensual"]
    default$Costo_Evaluacion = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="costos" & datosPais$indicador=="Assesment"]
    
    if (is.null(input$country) == F) {
      i_names = c()
      for (i in 1:17) {
        i_names = c(i_names,input_names[i])
      }
      
      i_labels = c()
      
      for (i in 1:17) {
        i_labels = c(i_labels,names(input_names)[i])
      }
      
      hepC_map_inputs = data.frame(
        intervencion = "Hepatitis C",
        i_names,
        i_labels
      )
      
      hepC_map_inputs$avanzado = NA
      hepC_map_inputs$avanzado[15:17] = T
      hepC_map_inputs$avanzado[1:14] = F
      
      rownames(hepC_map_inputs) = 1:nrow(hepC_map_inputs)
      
      save(
        hepC_map_inputs,
        file = "hepC_map_inputs.Rdata"
      )
      
    }
    
    tagList(
          lapply(input_names[15:17], function(i) {
            
            if (which(input_names==i) %in% porcentajes) {
              sliderInput(
                i,
                tags$div(
                  names(input_names[input_names==i]),
                  icon("circle-info",
                       "fa-1x",
                       title = inputs_hover[which(input_names==i)])
                ),
                min = 0,
                max = 100,
                default[[i]]*100
                
                
              )
            } else {
              numericInput(
                i,
                tags$div(
                  names(input_names[input_names==i]),
                  icon("circle-info",
                       "fa-1x",
                       title = inputs_hover[which(input_names==i)])
                ),
                default[[i]]
                
              )
            }
            
            
          })
        ,
        tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                    tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Avanzado")),
                    actionLink(inputId = "toggle_avanzado_hepC", label=icon("stream", style = "color: white;"))
        ),
          lapply(input_names[1:14], function(i) {
            hidden(
              if (which(input_names==i) %in% porcentajes) {
                sliderInput(
                  i,
                  tags$div(
                    names(input_names[input_names==i]),
                    icon("circle-info",
                         "fa-1x",
                         title = inputs_hover[which(input_names==i)])
                  ),
                  min=0,
                  max=100,
                  default[[i]]
                  
                )
              } else {
                numericInput(
                  i,
                  tags$div(
                    names(input_names[input_names==i]),
                    icon("circle-info",
                         "fa-1x",
                         title = inputs_hover[which(input_names==i)])
                  ),
                  default[[i]]
                  
                )
              }
              
              
            )
            
          })
        
      )
      
  
  
  
  
  })
  
  
}


ui_resultados_hepC = function(input,output,resultados) {
  hepC_run = resultados()

  output$hepC_summaryTable = renderReactable({
    
    if (length(hepC_run)>1) {
      table = hepC_run
      table$Valor = format(round(table$Valor,1),big.mark = ".",decimal.mark = ",")
      cat_epi = 1:5
      cat_costos = 6:nrow(table)
      
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
    reactableOutput("hepC_summaryTable")
  )

}


