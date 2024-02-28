ui_hepC = function (input, datosPais) {
  country_sel = str_to_title(input$country)
  
  renderUI({
    input_names = c(
      'Duración del tratamiento (meses)' = "tDuracion_Meses",
      'Costo de tratamiento mensual con Sofosbuvir/ Velpatasvir (Epclusa®) (USD)' = "Costo_Tratamiento",
      'Eficacia de Sofosbuvir/ Velpatasvir (Epclusa®) (%)' = "pSVR", 
      'Porcentaje de pacientes que abandonan el tratamiento (%)' = "pAbandono", 
      'Tamaño de la cohorte (n)' = "cohorte", 
      'Porcentaje de personas en estadío de fibrosis F0 al diagnóstico (%)' = "F0", 
      'Porcentaje de personas en estadío de fibrosis F1 al diagnóstico (%)' = "F1", 
      'Porcentaje de personas en estadío de fibrosis F2 al diagnóstico (%)' = "F2", 
      'Porcentaje de personas en estadío de fibrosis F3 al diagnóstico (%)' = "F3", 
      'Porcentaje de personas en estadío de fibrosis F4 al diagnóstico (%)' = "F4", 
      'Costos de estadío de fibrosis F0 a F2 al diagnóstico' = "aCostoF0F2", 
      'Costos de estadío de fibrosis F3 al diagnóstico' = "aCostoF3", 
      'Costos de estadío de fibrosis F4 al diagnóstico' = "aCostoF4",
      'Costo anual de cirrosis descompensada (USD)' = "aCostoDC", 
      'Costos anual de carcinoma hepatocelular (USD)' = "aCostoHCC", 
      #'Tasa de descuento (%)' = "AtasaDescuento", 
      'Costo de la evaluación de la respuesta al tratamiento' = "Costo_Evaluacion")
    
    inputs_hover = c(
      "Duración del tratamiento con Sofosbuvir (400 mg) y Velpatasvir (100 mg) en meses",
      "Costo de tratamiento mensual de Sofosbuvir/ Velpatasvir (Epclusa®). Régimen de AAD (antivirales de acción directa) de 4 semanas.",
      "Porcentaje de pacientes que logran la eliminación viral con el tratamiento antiviral específico que combina los medicamentos Sofosbuvir y Velpatasvir",
      "Porcentaje de pacientes que abandonan el tratamiento",
      "Número de personas mayores de 18 años con infección por VHC que ingresan al modelo",
      "Porcentaje de personas en estadío de fibrosis F0 al diagnóstico",
      "Porcentaje de personas en estadío de fibrosis F1 al diagnóstico",
      "Porcentaje de personas en estadío de fibrosis F2 al diagnóstico",
      "Porcentaje de personas en estadío de fibrosis F3 al diagnóstico",
      "Porcentaje de personas en estadío de fibrosis F4 al diagnóstico",
      "Costo anual del seguimiento, tratamiento y complicaciones de estadíos de fibrosis F0 a F2",
      "Costo anual del seguimiento, tratamiento y complicaciones de estadio de fibrosis F3",
      "Costo anual del seguimiento, tratamiento y complicaciones de estadio de fibrosis F4 (cirrosis)",
      "Costo anual del seguimiento, tratamiento y complicaciones de la cirrosis descompensada",
      "Costo anual del seguimiento, tratamiento y complicaciones del cáncer de hígado",
      #"Tasa para traer al presente los costos y beneficios en salud futuros",
      "Costo de implementar y sostener la intervención en un año"
      
    )
    
    bsc = 1:2
    avz = setdiff(1:length(inputs_hover),bsc)
    porcentajes = c(3,4,6:10)
    
    
    default = list()
    default$cohorte = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="Cohorte"]
    default$AtasaDescuento = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="Descuento"]
    default$F0 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="F0"]/100
    default$F1 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="F1"]/100
    default$F2 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="F2"]/100
    default$F3 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="F3"]/100
    default$F4 = datosPais$valor[datosPais$pais==country_sel & datosPais$dimension=="epi" & datosPais$indicador=="CC"]/100
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
      for (i in 1:length(inputs_hover)) {
        i_names = c(i_names,input_names[i])
      }
      
      i_labels = c()
      
      for (i in 1:length(inputs_hover)) {
        i_labels = c(i_labels,names(input_names)[i])
      }
      
      hepC_map_inputs = data.frame(
        intervencion = "Hepatitis C",
        i_names,
        i_labels
      )
      
      hepC_map_inputs$avanzado = NA
      hepC_map_inputs$avanzado[avz] = T
      hepC_map_inputs$avanzado[bsc] = F
      
      rownames(hepC_map_inputs) = 1:nrow(hepC_map_inputs)
      
      save(
        hepC_map_inputs,
        file = "hepC_map_inputs.Rdata"
      )
      
    }
    
    tagList(
          lapply(input_names[bsc], function(i) {
            
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
            } else {numericInput(
              i,
              tags$div(
                names(input_names[input_names==i]),
                icon("circle-info",
                     "fa-1x",
                     title = inputs_hover[which(input_names==i)])
              ),
              default[[i]]
              
            )}
            
            
          })
        ,
        tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                    tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Avanzado")),
                    actionLink(inputId = "toggle_avanzado_hepC", label=icon("stream", style = "color: white;"))
        ),
          lapply(input_names[avz], function(i) {
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
              
              
            )
            
          })
        
      )
      
  
  
  
  
  })
  
  
}


ui_grafico_nuevo_hepC = function(input,output,resultados) {
  table = resultados()
  if (length(table)>1) {
    colnames(table) = c("indicador","valor")
    
      indicadores = c(
        'Años de Vida Ajustados por Discapacidad evitados',
        'Costo total de la intervención (USD)',
        'Diferencia de costos respecto al escenario basal (USD)',
        'Retorno de Inversión (%)',
        'Razón de costo-efectividad incremental por Años de Vida Ajustados por Discapacidad evitada (USD)'
      )
      table = table[table$indicador %in% indicadores,]
      renderUI({
        graf_esc(table,output)
      })
      
      
    
  
  }
  

}


ui_resultados_hepC = function(input,output,resultados) {
  hepC_run = resultados()

  output$hepC_summaryTable = renderReactable({
    
    if (length(hepC_run)>1) {
      table = hepC_run
      table$Valor = format(round(table$Valor,1),big.mark = ".",decimal.mark = ",")
      cat_epi = 1:4
      cat_costos = 5:nrow(table)
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


