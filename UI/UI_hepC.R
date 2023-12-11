ui_hepC = function (input, datosPais) {
  
  country_sel = str_to_title(input$country)
  
  renderUI({
    input_names = c(
      "Costos de fibrosis descompensada" = "aCostoDC", 
      "Costos de estadíos de fibrosis F0 a F2" = "aCostoF0F2", 
      "Costos de estadío de fibrosis F3" = "aCostoF3", 
      "Costos de estadío de fibrosis F4" = "aCostoF4", 
      "Costos de carcinoma hepatocelular" = "aCostoHCC", 
      "Tasa de descuento" = "AtasaDescuento", 
      "Tamaño de la cohorte" = "cohorte", 
      "Costo de la evaluación de la respuesta al tratamiento" = "Costo_Evaluacion", 
      "Costo de tratamiento de 4 semanas de Epclusa" = "Costo_Tratamiento", 
      "Probabilidad de encontrarse en estadio de fibrosis F0 al diagnóstico" = "F0", 
      "Probabilidad de encontrarse en estadio de fibrosis F1 al diagnóstico" = "F1", 
      "Probabilidad de encontrarse en estadio de fibrosis F2 al diagnóstico" = "F2", 
      "Probabilidad de encontrarse en estadio de fibrosis F3 al diagnóstico" = "F3", 
      "Probabilidad de encontrarse en estadio de fibrosis F4 al diagnóstico" = "F4", 
      "Proporción de pacientes que abandonan el tratamiento." = "pAbandono", 
      "Eficacia de Sofosbuvir / velpatasvir" = "pSVR", 
      "Duración del tratamiento" = "tDuracion_Meses"
    )
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
            numericInput(
              i,
              names(input_names[input_names==i]),
              default[[i]]
              
            )
          })
        ,
        tags$header(class="text-1xl flex justify-between items-center p-5 mt-4", style="background-color: #FF671B; color: white; text-align: center", 
                    tags$h1(style="display: inline-block; margin: 0 auto;", class="flex-grow mt-8 mb-8",tags$b("Avanzado")),
                    actionLink(inputId = "toggle_avanzado_hepC", label=icon("stream", style = "color: white;"))
        ),
          lapply(input_names[1:14], function(i) {
            hidden(
              numericInput(
                i,
                names(input_names[input_names==i]),
                default[[i]]
                
              )
              
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


